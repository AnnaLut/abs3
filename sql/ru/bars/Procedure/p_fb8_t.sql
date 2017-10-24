

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FB8_T.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FB8_T ***

  CREATE OR REPLACE PROCEDURE BARS.P_FB8_T (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла #B8 для КБ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 25.03.2009 (11.02.09,05.02.09,04.02.09,03.02.09,31.01.09,
%                           12.02.08,04.02.08,28.02.06)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
11.02.2009 для счетов начисленных процентов 2068,2078,2208 ...
           будем формировать S270='01'
10.02.2009 для СБ (300465) будут включаться все счета 1590,1592,2400
           с различными R013 для остальных с R013='3'.
           Для 2209,3578,3579 будет определяться S270 от MAX даты
           начисления
05.02.2009 при формировании файла не включался бал.счет 1592(R013='3').
           Добавлено.
04.02.2009 изменил алгоритм разбивки остатка счетов просроченных %% по
           параметру R013.
03.02.2009 для счетов начисленных процентов не формировался код остатка
           первый символ в показателе. Исправлено.
30.01.2009 добавляется формирование параметра S270 код строку погашення
           основного боргу
01.02.2008 так как НБУ не поддерживает заполнение поля F_B8 в классифи-
           каторе KL_R020, а перечень бал.счетов включаемых в файл
           имеется в KOD_R020, то будем использовать KOD_R020 вместо
           KL_R020
12.02.2008 выполняется разбивка остатка по параметру R013
           (R013='1' остаток до 31 дня и R013='2' больше 31 дня)
           если в таблице PARAMS имеется строка PAR='RZPRR013'
           и VAL=0 или данная строка отсутствует в табл. PARAMS
           в остальных случаях используем спецпараметр счета R013 из
           SPECPARAM.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_     varchar2(2):='B8';
flag_     number;
typ_      number;
acc_      number;
acc1_     number;
nbs_      varchar2(4);
nbs1_     varchar2(4);
nls_      varchar2(15);
rnk_      Number;
isp_      Number;
data_     date;
dat1_     date;
dat2_     date;
wdate_    date;
kv_       SMALLINT;
Ostn_     DECIMAL(24);
Ostq_     DECIMAL(24);
Dos96_    DECIMAL(24);
Dosq96_   DECIMAL(24);
Kos96_    DECIMAL(24);
Kosq96_   DECIMAL(24);
se_       DECIMAL(24);
dk_       char(1);
kodp_     varchar2(20);
znap_     varchar2(30);
r013_     char(1);
s270_     varchar2(2);
s270_r    varchar2(2) := '00';
s270_p    varchar2(2);
s_        char(1);
r_        char(1);
userid_   number;
comm_      rnbu_trace.comm%TYPE;
mfo_       NUMBER;
mfou_      NUMBER;
nbuc1_    varchar2(12);
nbuc_     varchar2(12);
DatN_     date;
sql_acc_  varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_	  number;
sr013_    number;
sr013_60  number;
rzprr013_ number;

nd_        NUMBER;
-- ДО 30 ДНЕЙ
o_r013_1   VARCHAR2 (1);
o_se_1     DECIMAL (24);
o_comm_1   rnbu_trace.comm%TYPE;
-- ПОСЛЕ 30 ДНЕЙ
o_r013_2   VARCHAR2 (1);
o_se_2     DECIMAL (24);
o_comm_2   rnbu_trace.comm%TYPE;
ob22_      varchar2 (1) := '0';
us_id      number;

CURSOR Saldo IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs,
          NVL(trim(cc.r013),'0'), NVL(trim(cc.s270),'00'),
          s.ost, s.ostq, s.dos96, s.kos96, s.dosq96, s.kosq96, a.isp
   FROM  otcn_saldo s, specparam cc, otcn_acc a
   WHERE s.acc=a.acc
     and s.acc=cc.acc(+) ;

CURSOR BaseL IS
    SELECT kodp,nbuc,SUM (znap)
    FROM rnbu_trace
	WHERE userid=userid_
    GROUP BY kodp,nbuc
    ORDER BY kodp;
-----------------------------------------------------------------------------
--- процедура формирования протокола
procedure p_ins(p_dat_ date, p_tp_ varchar2, p_rnk_ number, p_nls_ varchar2,
                p_nbs_ varchar2, p_kv_ smallint, p_r013_ varchar2,
                p_s270_ varchar2, p_znap_ varchar2, p_isp_ number) IS
                kod_ varchar2(11);

begin

   if to_number(p_znap_) <> 0 then
      if Dat_ >= to_date('30012009','ddmmyyyy') then
         kod_:= p_tp_ || p_nbs_ || p_r013_ || p_s270_ ;
      else
         kod_:= p_tp_ || p_nbs_ || p_r013_ ;
      end if;

      INSERT INTO rnbu_trace
              (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
      VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, '0', rnk_, isp_, comm_ );
   end if;

end;
----------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
--DELETE FROM RNBU_TRACE WHERE userid = userid_;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------

 select max(id) into us_id
 from tmp_rez_risk
 where dat = Dat_;



-- свой МФО
   mfo_ := f_ourmfo ();

-- МФО "родителя"
   BEGIN
      SELECT mfou
        INTO mfou_
        FROM banks
       WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

--Dat1_ := TRUNC(Dat_,'MM');
--Dat2_ := add_months(Dat1_ - 1, 2);
--DatN_ := TRUNC(Dat_ +1 );

-- определение кода МФО или кода области для выбранного файла и схемы
--p_proc_set(kodf_,sheme_,nbuc1_,typ_);

--- удаление информации из табл. otcn_saldo
--- наполнение счетов (в том числе счетов тех.переоценки) и
--- их остатков (номиналы+эквиваленты)+обороты+корректирующие обороты
---DELETE FROM SALDO_OTCN WHERE odate=Dat_;
--EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_SALDO';

--sql_acc_ := 'select r020 from kl_r020 where prem=''КБ '' and f_b8=''1''';
-- вместо классификатора KL_R020 будем использовать KOD_R020
sql_acc_ := 'select r020 from kod_r020 where prem=''КБ '' and a010=''B8'' ';

ret_ := f_pop_otcn(Dat_, 2, sql_acc_);

ob22_ := getglobaloption('OB22');

BEGIN
   SELECT TO_NUMBER (NVL (val, '0'))
      INTO rzprr013_
   FROM params
   WHERE par = 'RZPRR013';
EXCEPTION WHEN NO_DATA_FOUND THEN
   rzprr013_ := '0';
END;
----------------------------------------------------------------------
----- обработка остатков
OPEN SALDO;
LOOP
   FETCH SALDO INTO rnk_, acc_, nls_, kv_, data_, nbs_, r013_, s270_,
                    Ostn_, Ostq_, Dos96_, Kos96_, Dosq96_, Kosq96_, isp_ ;
   EXIT WHEN SALDO%NOTFOUND;

   s270_r := '00';

   if typ_>0 then  --sheme_ = 'G' and (tips_<>'T00' and tips_<>'T0D') and typ_>0 then
      nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
   else
      nbuc_ := nbuc1_;
   end if;

   IF kv_ <> 980 THEN
      se_:=Ostq_-Dosq96_+Kosq96_;
   ELSE
      se_:=Ostn_-Dos96_+Kos96_;
   END IF;

   if dat_>=to_date('30012009','ddmmyyyy') and
      substr(nbs_,4,1) in ('8','9') and s270_='00' then
      BEGIN
         select a.acc, max(c.wdate)
            into acc1_, wdate_
         from nd_acc a, cc_deal c, accounts s
         where a.acc=acc_
           and a.acc=s.acc
           and s.tip='SS'
           and a.nd=c.nd
           and c.sdate <= Dat_
         group by a.acc;

         if dat_ - wdate_ <= 0 then
            s270_r := '01';
         elsif dat_ - wdate_ <= 180 then
            s270_r := '07';
         elsif dat_ - wdate_ > 180 then
            s270_r := '08';
         else
            null;
         end if;
      EXCEPTION WHEN NO_DATA_FOUND THEN
--         if nbs_ in ('2209','3578','3579') then
            BEGIN
               select acc, max(dapp)
                  into acc1_, wdate_
               from sal
               where acc=acc_
                 and dapp is not null
                 and dos <> 0
                 and fdat < Dat_
               group by acc;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               BEGIN
                  select acc, max(dapp)
                     into acc1_, wdate_
                  from sal
                  where acc=acc_
                    and dapp is not null
                    and dos >= 0
                    and fdat < Dat_
                  group by acc;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  BEGIN
                     select acc, min(fdat)
                        into acc1_, wdate_
                     from sal
                     where acc=acc_
                       and dapp is null
                       and dos >= 0
                       and fdat < Dat_
                     group by acc;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     null;
                  END;
               END;
            END;

            if dat_ - wdate_ <= 0 then
               s270_r := '01';
            elsif dat_ - wdate_ <= 180 then
               s270_r := '07';
            elsif dat_ - wdate_ > 180 then
               s270_r := '08';
            else
               null;
            end if;

         --end if;
         wdate_ := data_;
      END;
   end if;

   dk_ := iif_n (se_, 0, '1', '2', '2');

   if dat_>=to_date('30012009','ddmmyyyy') and nbs_ in ('1518','1528') then
      BEGIN
         select a.nbs
            into nbs1_
         from accounts a, int_accn i
         where i.acra=acc_
           and i.acc=a.acc
           and i.ID=0
           and ROWNUM=1;

         if nbs_ = '1518' and nbs1_ in ('1510','1512') and
            r013_ not in ('5','7') then
            r013_ := '5';
         end if;

         if nbs_ = '1518' and nbs1_ not in ('1510','1512') and
            r013_ not in ('6','8') then
            r013_ := '6';
         end if;

         if nbs_ = '1528' and nbs1_ = '1521' and
            r013_ not in ('5','7') then
            r013_ := '5';
         end if;

         if nbs_ = '1528' and nbs1_ <> '1521' and
            r013_ not in ('6','8') then
            r013_ := '6';
         end if;

      EXCEPTION WHEN NO_DATA_FOUND THEN
         NULL;
      END;

   end if;

   comm_ := 'R013=' || r013_;

   -- счета начисленных процентов
   IF dat_>=to_date('30012009','ddmmyyyy') and substr(nbs_,4,1) = '8' THEN
      if mfo_ not in (300465,333368) then
         p_analiz_r013 (mfo_,
                        mfou_,
                        dat_,
                        acc_,
                        nbs_,
                        kv_,
                        r013_,
                        se_,
                        nd_,
                        --------
                        o_r013_1,
                        o_se_1,
                        o_comm_1,
                        --------
                        o_r013_2,
                        o_se_2,
                        o_comm_2
                       );

         -- до 30 дней
         IF o_se_1 <> 0
         THEN
            if s270_ not in ('01','07','08') and s270_r in ('01','07','08') then
               s270_ := s270_r;
            end if;
--            s270_ := '01';
            IF dat_ >= TO_DATE ('30012009', 'ddmmyyyy')
            THEN
               kodp_ := dk_ || nbs_ || o_r013_1 || s270_;
            ELSE
               kodp_ := dk_ || nbs_ || o_r013_1;
            END IF;

            znap_ := TO_CHAR (ABS (o_se_1));

            INSERT INTO rnbu_trace
                        (nls, kv, odate, kodp, znap, nbuc, rnk, isp,
                         comm, nd, acc
                        )
                 VALUES (nls_, kv_, data_, kodp_, znap_, '0', rnk_, isp_,
                         comm_ || o_comm_1, nd_, acc_
                        );
         END IF;

         -- свыше 30 дней
         IF o_se_2 <> 0
         THEN
            if s270_ not in ('01','07','08') and s270_r in ('01','07','08') then
               s270_ := s270_r;
            end if;
--            s270_ := '07';
            IF dat_ >= TO_DATE ('30012009', 'ddmmyyyy')
            THEN
               kodp_ := dk_ || nbs_ || o_r013_2 || s270_;
            ELSE
               kodp_ := dk_ || nbs_ || o_r013_2;
            END IF;

            znap_ := TO_CHAR (ABS (o_se_2));

            INSERT INTO rnbu_trace
                       (nls, kv, odate, kodp, znap, nbuc, rnk, isp,
                        comm, nd, acc
                        )
                 VALUES (nls_, kv_, data_, kodp_, znap_, '0', rnk_, isp_,
                         comm_ || o_comm_2, nd_, acc_
                        );
         END IF;
      else
         if se_ <> 0 then
            if s270_ not in ('01','07','08') and s270_r in ('01','07','08') then
               s270_ := s270_r;
            end if;
--            s270_ := '01';
            IF dat_ >= TO_DATE ('30012009', 'ddmmyyyy')
            THEN
               kodp_ := dk_ || nbs_ || r013_ || s270_;
            ELSE
               kodp_ := dk_ || nbs_ || r013_;
            END IF;

            znap_ := TO_CHAR (ABS (se_));

            INSERT INTO rnbu_trace
                       (nls, kv, odate, kodp, znap, nbuc, rnk, isp,
                        comm, nd, acc
                        )
                 VALUES (nls_, kv_, data_, kodp_, znap_, '0', rnk_, isp_,
                         comm_, nd_, acc_
                        );
         end if;

      end if;

   END IF;

   if substr(nbs_,4,1) = '9' then
      comm_ := '';

      select count(*)
         into flag_
      from tmp_rez_risk
      where dat=Dat_
        and nls=nls_
        and kv=kv_
        and id = us_id;

      if rzprr013_ = '0' then
         sr013_:=gl.p_icurval(kv_,otcn_pkg.f_GET_R013(acc_,dat_),dat_);
         comm_ := comm_ ||' сума залишку ='||to_char(ABS(se_)) ||
                  ' сума залишку зв.дата-31 ='||to_char(ABS(sr013_));
      else
         sr013_:=0;
      end if;


--      IF ((mfo_ not in ('300465','333368') and
--           r013_ in ('0','1') and se_<>0 and sr013_<>0 and
--           abs(sr013_)<abs(se_))
--          OR
--          (mfo_ in ('300465','333368') and
--           r013_ in ('0','1','2','3') and se_<>0 and sr013_<>0 and
--           abs(sr013_)<abs(se_)) ) then

      IF r013_ in ('0','1') and se_<>0 and sr013_<>0 and abs(sr013_)<abs(se_) then

         if s270_='00' and s270_r in ('01','07','08') then
            s270_ := s270_r;
         end if;

         -- виконуємо розбивку по R013 при наявностi в TMP_REZ_RISK
         if flag_ > 0 then
            dk_:=IIF_N(se_,0,'1','2','2');
            dat1_ := dat_ - 29; --30;  --29 ;  --1 ;
            sr013_60 := gl.p_icurval(kv_,otcn_pkg.f_GET_R013(acc_,dat1_),dat1_);

            if se_<>0 and sr013_60 <> 0 and abs(sr013_60) < abs(sr013_) THEN
               comm_ := comm_ || ' сума залишку зв.дата-(32-60) ='||to_char(ABS(sr013_60));
               s270_p := s270_;
               p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '3', s270_p, TO_CHAR(abs(sr013_60)), isp_);
               p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '2', s270_p, TO_CHAR(abs(sr013_)-abs(sr013_60)), isp_);
               if ob22_ = '0' and s270_ = '08' then
                  s270_p := '07';
               end if;
               p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '1', s270_p, TO_CHAR(abs(se_)-abs(sr013_)), isp_);
            end if;

            if ABS(sr013_)-ABS(sr013_60) = 0 and sr013_60 <> 0 then
               s270_p := s270_;
               p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '3', s270_p, TO_CHAR(abs(sr013_)), isp_);
               if ob22_ = '0' and s270_ = '08' then
                  s270_p := '07';
               end if;
               p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '1', s270_p, TO_CHAR(abs(se_)-abs(sr013_)), isp_);
            end if;

            if ABS(sr013_)-ABS(sr013_60) < 0 and sr013_60 <> 0 then
               s270_p := s270_;
               p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '2', s270_p, TO_CHAR(abs(sr013_)), isp_);
               if ob22_ = '0' and s270_ = '08' then
                  s270_p := '07';
               end if;
               p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '1', s270_p, TO_CHAR(abs(se_)-abs(sr013_)), isp_);
            end if;

            if ABS(sr013_)-ABS(sr013_60) > 0 and ABS(sr013_60) = 0 then
               s270_p := s270_;
               p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '2', s270_p, TO_CHAR(abs(sr013_)), isp_);
               if ob22_ = '0' and s270_ = '08' then
                  s270_p := '07';
               end if;
               p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '1', s270_p, TO_CHAR(abs(se_)-abs(sr013_)), isp_);
            end if;

--         p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '1', s270_p, TO_CHAR(abs(se_)-abs(sr013_)), isp_);
         else
            p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, r013_, s270_, TO_CHAR(abs(se_)), isp_);
         end if;
      elsif se_<>0 THEN
         -- при вiдсутностi в TMP_REZ_RISK параметр R013='1'
--         if flag_ = 0 then
--            r013_ := '1';
--         end if;

         dk_:=IIF_N(se_,0,'1','2','2');

         if s270_ in ('01','07','08') then
            s270_p := s270_;
         end if;

         if s270_ = '00' and s270_r in ('01','07','08') then
            s270_p := s270_r;
         end if;

         if ob22_ = '0' and r013_ = '1' and s270_='00' and s270_p='08' then
            s270_p := '07';
         end if;

         if r013_ in ('0','1','2') and ABS(se_)=ABS(sr013_) and sr013_<>0 then
            dat1_ := dat_ - 29;
            sr013_60 := gl.p_icurval(kv_,otcn_pkg.f_GET_R013(acc_,dat1_),dat1_);

            if se_<>0 and sr013_60 <> 0 and abs(sr013_60) < abs(sr013_) THEN
               comm_ := comm_ || ' сума залишку зв.дата-(32-60) ='||to_char(ABS(sr013_60));
               s270_p := s270_;
               p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '3', s270_p, TO_CHAR(abs(sr013_60)), isp_);
               p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '2', s270_p, TO_CHAR(abs(sr013_)-abs(sr013_60)), isp_);
            end if;

            if se_<>0 and sr013_60 <> 0 and abs(sr013_60) > abs(sr013_) THEN
               s270_p := s270_;
               p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '2', s270_p, TO_CHAR(abs(sr013_)), isp_);
            end if;

            if se_<>0 and sr013_60 <> 0 and abs(sr013_60) = abs(sr013_) THEN
               s270_p := s270_;
               p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '3', s270_p, TO_CHAR(abs(sr013_)), isp_);
            end if;
            if se_<>0 and sr013_60 = 0 THEN
               s270_p := s270_;
               p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '2', s270_p, TO_CHAR(abs(sr013_)), isp_);
            end if;
         else
            p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, r013_, s270_p, TO_CHAR(ABS(se_)), isp_);
         end if;

      END IF;
   end if;

   if dat_>=to_date('30012009','ddmmyyyy') then
      if nbs_ in ('1590','1592','2400') then
         dk_:=IIF_N(se_,0,'1','2','2');
         p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, r013_, s270_, TO_CHAR(ABS(se_)), isp_);
      end if;
   end if;

END LOOP;
CLOSE SALDO;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        (kodf_, Dat_, kodp_, znap_, nbuc_);
END LOOP;
CLOSE BaseL;
----------------------------------------
END p_fb8_T;
/
show err;

PROMPT *** Create  grants  P_FB8_T ***
grant EXECUTE                                                                on P_FB8_T         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FB8_T         to RCC_DEAL;
grant EXECUTE                                                                on P_FB8_T         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FB8_T.sql =========*** End *** =
PROMPT ===================================================================================== 
