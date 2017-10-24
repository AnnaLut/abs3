

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FG2_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FG2_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FG2_NN (Dat_ DATE,
                                      sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирование файла #02 для КБ
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 24.07.2009 (20.07.09,10.06.09,01.04.09,04.04.08,07.03.08,
%                           04.02.08,03.10.06)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования

27.07.2009 в курсоре SALDO пока оставил таблицу OTCN_ACC до выполнения
           расширения таблицы OTCN_SALDO (добавление поля "TIP")
24.07.2009 в курсоре SALDO убрал таблицу OTCN_ACC т.к. поле "TIP" внесено
           в табл. OTCN_SALDO
20.07.2009 для 9910 изменил блок заполнения показателя
12.07.2009 для 3800_000000000 изменяем код валюты только для остатков
02.06.2009 добавил для Ровно СБ по счетам 9910_001% будем брать только
           остатки эквивалент ("10","20") т.к. в файле #01.
           для Ровно СБ для счетов тех.переоценки и кодов валют не 643,840,
           978 при отсутствии номинала изменяем код валюты на 978 т.к.
           для этой валюты всегда есть номинал (как в ОПЕРРУ СБ).
01.04.2009 не изменяем код валюты для счетов тех.переоценки бал.счетов
           и внебалансовых счетов
04.04.2008 ОПЕРУ СБ для счетов тех.переоценки и кодов валют не 643,840,
           978 при отсутствии номинала изменяем код валюты на 978 т.к.
           для этой валюты всегда есть номинал.
           Если есть эквивалент и нет номинала возникает ошибка при
           внутреннем контроле(пр-мма Сбербанка) и тогда выполняется
           ручная корректировка файла.
07.03.2008 для банка Киев вызывается процедура проверки P_CH_FILE01
04.02.2008 так как НБУ не поддерживает заполнение поля F_01 в классифи-
           каторе KL_R020, а перечень бал.счетов включаемых в файл
           имеется в KOD_R020, то будем использовать KOD_R020 вместо
           KL_R020
03.10.2006 для бал.счета 3929 добавил вычитание корректирующих проводок
           из оборотов за месяц (ранее не предполагались кор.проводки по
           данному бал.счету)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='02';
rnk_     number;
typ_      number;
acc_     Number;
dat1_    Date;
--dat2_    Date;
--datn_    date;
dig_     Number;
Dos_     DECIMAL(24);
Dosq_    DECIMAL(24);
Kos_     DECIMAL(24);
Kosq_    DECIMAL(24);
Dos96p_  DECIMAL(24);
Dosq96p_ DECIMAL(24);
Kos96p_  DECIMAL(24);
Kosq96p_ DECIMAL(24);
Dos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kos96_   DECIMAL(24);
Kosq96_  DECIMAL(24);
Dos99_   DECIMAL(24);
Dosq99_  DECIMAL(24);
Kos99_   DECIMAL(24);
Kosq99_  DECIMAL(24);
Doszg_   DECIMAL(24);
Koszg_   DECIMAL(24);
Dos96zg_ DECIMAL(24);
Kos96zg_ DECIMAL(24);
Dos99zg_ DECIMAL(24);
Kos99zg_ DECIMAL(24);
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
kodp_    Varchar2(10);
znap_    Varchar2(30);
Kv_      SMALLINT;
Kv1_     SMALLINT;
--Vob_     SMALLINT;
Nbs_     Varchar2(4);
nls_     Varchar2(15);
mfo_     number;
mfou_    NUMBER;
data_    Date;
k041_    Char(1);
dk_      varchar2(2);
--nbu_     SMALLINT;
prem_    Char(3);
userid_  Number;
nbuc1_   Varchar2(12);
nbuc_    Varchar2(12);
b_       Varchar2(30);
tips_    Varchar2(3);
flag_    number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ff_      number;
ret_     number;
pr_      NUMBER;
-------------------------------------------------------------------------------
CURSOR Saldo IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96p, s.dosq96p, s.kos96p, s.kosq96p,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg,
          a.tip, nvl(l.k041,'1')
   FROM  otcn_saldo s, customer cc, kl_k040 l, otcn_acc a
   WHERE a.acc=s.acc    and
         a.rnk=cc.rnk   and
         NVL(lpad(to_char(cc.country),3,'0'),'804')=l.k040(+) ;
---------------------------------------------------------------------------
CURSOR BaseL IS
    SELECT kodp, nbuc, SUM (znap)
    FROM rnbu_trace
    WHERE userid=userid_
    GROUP BY kodp,nbuc
    ORDER BY kodp;
---------------------------------------------------------------------------
-------------------------------------------------------------------------------
procedure p_ins(p_dat_ date, p_tp_ varchar2, p_nls_ varchar2,p_nbs_ varchar2,
          p_kv_ smallint, p_k041_ varchar2, p_znap_ varchar2) IS
                kod_ varchar2(10);

begin

   if p_nbs_='6204' and p_kv_<>980 then
      kod_ := p_tp_||'3800'||lpad(p_kv_,3,'0')||p_k041_;
      INSERT INTO rnbu_trace
              (nls, kv, odate, kodp, znap, nbuc)
      VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, nbuc_);
   else
   if length(trim(p_tp_))=1 then
      IF p_kv_=980 THEN
         kod_:='0' ;
      ELSE
         kod_:='1' ;
      END IF ;
   else
      kod_:= '';
   end if;

   kod_:= p_tp_ || kod_ || p_nbs_ || lpad(p_kv_,3,'0') || p_k041_ ;

   if length(trim(p_tp_))>1 then
      flag_ := f_is_est(p_nls_, p_kv_);
      IF flag_=1 AND mfo_<>315568 and mfo_ not in (333368,303398,311647) THEN
         kod_:= p_tp_ || p_nbs_ || '980' || p_k041_ ;
      END IF;
   end if;

   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, nbuc)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, nbuc_);

   end if;

end;
-------------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
-- свой МФО
mfo_ := F_Ourmfo ();

-- МФО "родителя"
BEGIN
   SELECT mfou
     INTO mfou_
     FROM BANKS
    WHERE mfo = mfo_;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      mfou_ := mfo_;
END;

-- определение кода области для выбранного файла и схемы
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

--- удаление информации из табл. otcn_acc, otcn_saldo
--- наполнение счетов (в том числе счетов тех.переоценки) и
--- их остатков (номиналы+эквиваленты)+обороты+корректирующие обороты
--- все эти действия выполняются в функции F_POP_OTCN

--sql_acc_ := 'select r020 from kl_r020 where prem=''КБ '' and f_01=''1''';
-- вместо классификатора KL_R020 будем использовать KOD_R020
sql_acc_ := 'select r020 from kod_r020 where prem=''КБ '' and a010=''02'' ';

ret_ := f_pop_otcn_gi(Dat_, 3, sql_acc_);

Dat1_ := TRUNC(Dat_,'MM'); -- початок попереднього м_сяця
----------------------------------------------------------------------------
OPEN Saldo;
   LOOP
   FETCH Saldo INTO rnk_, acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                    Dos_, Dosq_, Kos_, Kosq_,
                    Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                    Dos96_, Dosq96_, Kos96_, Kosq96_,
                    Dos99_, Dosq99_, Kos99_, Kosq99_,
                    Doszg_, Koszg_, Dos96zg_, Kos96zg_,
                    tips_, k041_;
   EXIT WHEN Saldo%NOTFOUND;

   if sheme_ = 'G' and (tips_<>'T00' and tips_<>'T0D') and typ_>0 then
      nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
   else
      nbuc_ := nbuc1_;
   end if;

--- обороты по перекрытию 6,7 классов на 5040,5041
   IF to_char(Dat_,'MM')='12' THEN
--      p_pr_ZG(acc_,dat_,Doszg_,Koszg_);   --- старый вариант процедуры
      Dos_:=Dos_-Doszg_;
      Kos_:=Kos_-Koszg_;
      Ostn_:=Ostn_+Doszg_-Koszg_;
   END IF;

   Dos_:=Dos_-Dos96p_-Dos99_;
   Dosq_:=Dosq_-Dosq96p_-Dosq99_;
   Kos_:=Kos_-Kos96p_-Kos99_;
   Kosq_:=Kosq_-Kosq96p_-Kosq99_;

   IF (substr(nls_,1,4)='3929' AND Kv_=980) or (tips_='ASG' and 300120 NOT IN (mfo_, mfou_)) THEN
      if mfo_ = 322498 then
         -- Будет с 01.11.2005
         IF substr(nls_,1,4)='3929' AND Kv_=980 THEN
            SELECT SUM(iif_n(dos-kos,0,0,0,dos-kos)),
                   SUM(iif_n(kos-dos,0,0,0,kos-dos))
            INTO Dos_, Kos_
            from sal
            where acc=acc_ and substr(nls,1,4)='3929' and
                  kv=980 and dos+kos<>0 and
                  fdat between Dat1_ and Dat_;

            Dos_:=Dos_ - Dos96p_;
            Kos_:=Kos_ - Kos96p_;

         END IF;
      else
         IF Dos_=Kos_ THEN
            Dos_:=0;
            Kos_:=0;
         END IF;

         IF Dos_ > Kos_ THEN
            Dos_:=Dos_-Kos_ ;
            Kos_:=0;
         END IF;

         IF Dos_ < Kos_ THEN
            Kos_:=Kos_-Dos_ ;
            Dos_:=0;
         END IF;

         IF Dosq_=Kosq_ THEN
            Dosq_:=0;
            Kosq_:=0;
         END IF;

         IF Dosq_ > Kosq_ THEN
            Dosq_:=Dosq_-Kosq_ ;
            Kosq_:=0;
         END IF;

         IF Dosq_ < Kosq_ THEN
            Kosq_:=Kosq_-Dosq_ ;
            Dosq_:=0;
         END IF;
      END IF;
   END IF;

-- начало ** вставил 28.09.2005
   IF Dos_ < 0 THEN
      Kos_:=Kos_+ABS(Dos_);
   END IF;

   IF Kos_ < 0 THEN
      Dos_:=Dos_+ABS(Kos_);
   END IF;
-- окончание **

   IF Dosq_ < 0 THEN
      Kosq_:=Kosq_+ABS(Dosq_);
   END IF;

   IF Kosq_ < 0 THEN
      Dosq_:=Dosq_+ABS(Kosq_);
   END IF;

   IF Dos_ > 0 THEN
      p_ins(data_, '5', nls_, nbs_, kv_, k041_, TO_CHAR(Dos_));
   END IF;

   IF Dosq_ > 0 THEN
      p_ins(data_, '50', nls_, nbs_, kv_ , k041_, TO_CHAR(Dosq_));
   END IF;

   IF Kos_ > 0 THEN
      p_ins(data_, '6', nls_, nbs_, kv_, k041_, TO_CHAR(Kos_));
   END IF;

   IF Kosq_ > 0 THEN
      p_ins(data_, '60', nls_, nbs_, kv_ , k041_, TO_CHAR(Kosq_));
   END IF;

   IF Dos96_ > 0 THEN
      p_ins(data_, '7', nls_, nbs_, kv_, k041_, TO_CHAR(Dos96_));
   END IF;

   IF Dosq96_ > 0 THEN
      p_ins(data_, '70', nls_, nbs_, kv_, k041_, TO_CHAR(Dosq96_));
   END IF;

   IF Kos96_ > 0 THEN
      p_ins(data_, '8', nls_, nbs_, kv_, k041_, TO_CHAR(Kos96_));
   END IF;

   IF Kosq96_ > 0 THEN
      p_ins(data_, '80', nls_, nbs_, kv_, k041_, TO_CHAR(Kosq96_));
   END IF;

   IF Dos99_ > 0 THEN
      p_ins(data_, '9', nls_, nbs_, kv_, k041_, TO_CHAR(Dos99_));
   END IF;

   IF Dosq99_ > 0 THEN
      p_ins(data_, '90', nls_, nbs_, kv_, k041_, TO_CHAR(Dosq99_));
   END IF;

   IF Kos99_ > 0 THEN
      p_ins(data_, '0', nls_, nbs_, kv_, k041_, TO_CHAR(Kos99_));
   END IF;

   IF Kosq99_ > 0 THEN
      p_ins(data_, '00', nls_, nbs_, kv_, k041_, TO_CHAR(Kosq99_));
   END IF;

   Ostn_:=Ostn_-Dos96_+Kos96_;
   IF Ostn_<>0 THEN
      dk_:=IIF_N(Ostn_,0,'1','2','2');
      p_ins(data_, dk_, nls_, nbs_, kv_, k041_, TO_CHAR(ABS(Ostn_)));
   END IF;

   Ostq_:=Ostq_-Dosq96_+Kosq96_;
   IF Ostq_<>0 THEN
      dk_:=IIF_N(Ostq_,0,'1','2','2')||'0';
      p_ins(data_, dk_ , nls_, nbs_, kv_ , k041_, TO_CHAR(ABS(Ostq_)));
   END IF;

END LOOP;
CLOSE Saldo;
---------------------------------------------------------------------------
-- 04.04.2008
-- по просьбе ОПЕРУ СБ для счетов тех.переоценки изменяем код валюты на 978
-- при отсутствии номинала для данной валюты с 01.03.2008
--IF mfo_=322498 and Dat_ >= to_date('01032006','ddmmyyyy') then
IF mfo_ IN (300465,333368) and Dat_ >= to_date('01032008','ddmmyyyy') then
   for k in (select nls, kv, kodp
             from rnbu_trace
             where nls LIKE '3800_000000000%'
               and kv not in (643, 840, 978) )
   loop

      IF substr(k.kodp,1,2) in ('10','20') THEN
         select count(*)
            into pr_
         from rnbu_trace
         where substr(kodp,1,2)=substr(k.kodp,1,1)||'1'
           and substr(kodp,3,8)=substr(k.kodp,3,8);

         IF pr_=0 then
            kodp_:= substr(k.kodp,1,6) || '978' || substr(k.kodp,-1) ;
            update rnbu_trace set kodp=kodp_
            where nls=k.nls
              and kv=k.kv;
         END IF;
      END IF;

   end loop;

END IF;
----------------------------------------------------------------------------
-- при отсутствии номинала для данной валюты с 01.03.2008
IF mfo_ in (333368) and Dat_ >= to_date('01032008','ddmmyyyy') then

   kodp_ := null;

   for k in (select nls, kv, kodp
             from rnbu_trace
             where nls LIKE '9910_001%'
               and kv != 980
             order by nls, kv, substr(kodp,1,2))
   loop

      IF substr(k.kodp,1,2) in ('10','20') THEN
         select count(*)
            into pr_
         from rnbu_trace
         where substr(kodp,1,2)=substr(k.kodp,1,1)||'1'
           and substr(kodp,3,8)=substr(k.kodp,3,8);

         IF pr_=0 then

            select count(*)
               into pr_
            from rnbu_trace
            where substr(kodp,1,2)=substr(k.kodp,1,1)||'1'
              and substr(kodp,3,4)='9900'
              and substr(kodp,7,3)=k.kv;

            if pr_ <> 0 then
               kodp_:= substr(k.kodp,1,2) ||'9900' || k.kv || substr(k.kodp,-1) ;
               nls_ := k.nls;
               kv_  := k.kv;
               update rnbu_trace set kodp=kodp_
               where nls=k.nls
                 and kv=k.kv
                 and substr(kodp,1,2)=substr(k.kodp,1,2);
            else
               select count(*)
                  into pr_
               from rnbu_trace
               where substr(kodp,1,2)=substr(k.kodp,1,1)||'1'
                 and substr(kodp,3,4)='9900'
                 and substr(kodp,7,3)='978';

               if pr_ = 0 then
                  select count(*)
                     into pr_
                  from rnbu_trace
                  where substr(kodp,1,2)=substr(k.kodp,1,1)||'1'
                    and substr(kodp,3,4)='9900'
                    and substr(kodp,7,3)='840';

                  if pr_ <> 0 then
                     kodp_:= substr(k.kodp,1,2) ||'9900' || '840' || substr(k.kodp,-1) ;
                     nls_ := k.nls;
                     kv_  := k.kv;
                     update rnbu_trace set kodp=kodp_
                     where nls=k.nls
                       and kv=k.kv
                       and substr(kodp,1,2)=substr(k.kodp,1,2);
                  end if;
               else
                  kodp_:= substr(k.kodp,1,2) ||'9900' || '978' || substr(k.kodp,-1) ;
                  nls_ := k.nls;
                  kv_  := k.kv;
                  update rnbu_trace set kodp=kodp_
                  where nls=k.nls
                    and kv=k.kv
                    and substr(kodp,1,2)=substr(k.kodp,1,2);
               end if;
            end if;
         ELSE
            kodp_:=null;
         END IF;
      END IF;

      if kodp_ is not null and substr(k.kodp,1,2) in ('50','60') and
         k.nls=nls_ and k.kv=kv_ then

         select count(*)
            into pr_
         from rnbu_trace
         where substr(kodp,1,2)=substr(k.kodp,1,1)||'1'
           and substr(kodp,3,8)=substr(k.kodp,3,8);

         IF pr_=0 then
            update rnbu_trace set kodp=substr(k.kodp,1,2)||substr(kodp_,3,8)
            where nls=k.nls
              and kv=k.kv
              and substr(kodp,1,2)=substr(k.kodp,1,2);
         END IF;
      end if;

   end loop;

END IF;

for k in (select a.nls_bars, a.kv,
                 sum(a.dos) dos, sum(a.kos) kos,
                 sum(a.dos_v) dosv, sum(a.kos_v) kosv,
                 nvl(l.k041,'1') k041
          from test_s6_obnls a, accounts s,
               customer c, kl_k040 l
          where a.fdat >= to_date('01102009','ddmmyyyy')
            and a.fdat <= to_date('23102009','ddmmyyyy')
            and a.nls_bars is not null
            and a.nls_bars=s.nls(+)
            and a.nls_bars not like '8%'
            and a.kv=s.kv(+)
            and s.rnk=c.rnk(+)
            and NVL(lpad(to_char(c.country),3,'0'),'804')=l.k040(+)
            group by a.nls_bars, a.kv, nvl(l.k041,'1'))

    loop

       nbs_ := substr(k.nls_bars,1,4);
       data_ := to_date('23102009','ddmmyyyy');

       if ((nbs_='6204' and k.kv=980) or nbs_<>'6204') and k.dos <> 0 then
          kodp_ := '50'||nbs_||lpad(to_char(k.kv),3,'0')|| k.k041;
          znap_ := to_char(k.dos);
          insert into rnbu_trace
                   (nls, kv, odate, kodp, znap, nbuc)
           VALUES  (k.nls_bars, k.kv, data_, kodp_, znap_, '311647');
       end if;

       if ((nbs_='6204' and k.kv=980) or nbs_<>'6204') and k.kos <> 0 then
          kodp_ := '60'||nbs_||lpad(to_char(k.kv),3,'0')|| k.k041;
          znap_ := to_char(k.kos);
          insert into rnbu_trace
                   (nls, kv, odate, kodp, znap, nbuc)
           VALUES  (k.nls_bars, k.kv, data_, kodp_, znap_, '311647');
       end if;

       if k.dosv <> 0 then
          kodp_ := '51'||nbs_||lpad(to_char(k.kv),3,'0')|| k.k041;
          znap_ := to_char(k.dosv);
          insert into rnbu_trace
                   (nls, kv, odate, kodp, znap, nbuc)
           VALUES  (k.nls_bars, k.kv, data_, kodp_, znap_, '311647');
       end if;

       if k.kosv <> 0 then
          kodp_ := '61'||nbs_||lpad(to_char(k.kv),3,'0')|| k.k041;
          znap_ := to_char(k.kosv);
          insert into rnbu_trace
                   (nls, kv, odate, kodp, znap, nbuc)
           VALUES  (k.nls_bars, k.kv, data_, kodp_, znap_, '311647');
       end if;

    end loop;

---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf=dat_;
---------------------------------------------------
kv1_:=0;
dig_:=100;

OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   if substr(kodp_,7,3)='980' or substr(kodp_,2,1)<>'1' then
      b_:=znap_;
   else
      IF kv1_ <> to_number(substr(kodp_,7,3)) THEN
         dig_:=f_ret_dig(to_number(substr(kodp_,7,3)));

         kv1_:=to_number(substr(kodp_,7,3));
      END IF;

      b_:=TO_CHAR(ROUND(TO_NUMBER(znap_)/dig_,0));
   end if;

   INSERT INTO tmp_nbu
      (kodf, datf, kodp,  znap, nbuc)
   VALUES
      (kodf_, Dat_, kodp_, b_, nbuc_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
if mfo_ = 322498 then
   P_Ch_File01('02',dat_,userid_);
end if;
--------------------------------------------------------
END p_fg2_NN;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FG2_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
