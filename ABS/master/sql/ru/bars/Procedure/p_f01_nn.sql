

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F01_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F01_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F01_NN (Dat_ DATE,
                                      sheme_ VARCHAR2 DEFAULT 'G',
                                      tipost_ VARCHAR2 DEFAULT 'S',
                                      kodf_    VARCHAR2 DEFAULT '01') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #01 для КБ (универсальная)
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 23.10.2009 (23.09.09,22.09.09,20.07.09,11.06.09,03.06.09,
%             :             05.03.08,25.02.08,04.02.08,13.02.06)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
           tipost_ - тип остатков 6 и 7 классов
                     'S'-с учетом проводок перекрытия на 5040(5041)
                     'R'- без учета проводок перекрытия на 5040(5041)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 23.10.2009 для внебал. счета 9910_001% добавлен код МФО=311647
%            для МФО=311647 и внебал. счета 9910_001% не меняем код валюти
%            не 980 на 980
% 23.09.2009 для МФО=303398 и внебал. счета 9910_001% не меняем код валюти
%            не 980 на 980
% 22.09.2009 для внебал. счета 9910_001% добавлен код МФО=303398
% 20.07.2009 для Ровно СБ изменен блок наполнения в OTCN_SALDO(функция
%            F_POP_OTCN) и в курсоре SALDO исключены табл. OTCN_ACC,
%            CUSTOMER
% 11.06.2009 для Ровно СБ по счетам 9910_001% изменены некоторые условия
% 03.06.2009 для Ровно СБ по счетам 9910_001% будем брать только остатки
%            эквивалент ("10","20").
% 26.02.2008 ОПЕРУ СБ для счетов тех.переоценки и кодов валют не 643,840,
%            978 изменяем код валюты на 978 т.к. для этих валют есть
%            эквивалент и нет номинала (ошибка при внутреннем контроле)
% 25.02.2008 в процедуре от 22.09.2005 выполнялись переоценки валютной
%            позиции и переоценка остатков валютных счетов, а 17.01.2006
%            ее исключили. По просьбе банка Демарк оставил переоценку.
%            оставляю переоценку для банков СЭБ(300175), УПБ(300205),
%            Сбербанк(300465)
%            Для курсора SALDO добавлено "(*+ INDEX(cc) *)".
% 04.02.2008 так как НБУ не поддерживает заполнение поля F_01 в классифи-
%            каторе KL_R020, а перечень бал.счетов включаемых в файл
%            имеется в KOD_R020, то будем использовать KOD_R020 вместо
%            KL_R020
% 24.01.2006 для Хмельницкой Укоопспилки МФО=315568 не изменяем код валюты
%            на 980 по счетам тех.переоценки 3500 или 3600 (у них такие)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
--kodf_    VARCHAR2(2):='01';
typ_     NUMBER;
rnk_     NUMBER;
acc_     NUMBER;
nbs_     VARCHAR2(4);
kv_      SMALLINT;
nls_     VARCHAR2(15);
mfo_     VARCHAR2(12);
mfou_    NUMBER;
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(20);
--s0000_   Varchar2(15);
--s3500_   Varchar2(15);
--s3600_   Varchar2(15);
--s0009_   Varchar2(15);
data_    DATE;
re_      SMALLINT;
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dose_    DECIMAL(24);
dk_      VARCHAR2(2);
kodp_    VARCHAR2(10);
znap_    VARCHAR2(30);
userid_  NUMBER;
dig_     NUMBER;
b_       VARCHAR2(30);
flag_    NUMBER;
pr_      NUMBER;
tips_    VARCHAR2(3);
tsql_    VARCHAR2(1000);
sql_acc_ VARCHAR2(2000):='';
ret_	 NUMBER;
pr_accc  NUMBER;

--был курсор до изменения 16.07.2009
CURSOR SALDO IS
   SELECT a.acc, a.nls, a.kv, a.nbs, s.FDAT, NVL(MOD(cc.CODCAGENT,2),1),
          NVL(s.ost,0), NVL(s.ostq,0), a.tip, cc.rnk
   FROM OTCN_SALDO s, OTCN_ACC a, CUSTOMER cc
   WHERE s.acc = a.acc
     AND a.rnk = cc.rnk;

-- после изменения структуры табл. OTCN_ACC, OTCN_SALDO
-- в OTCN_ACC добавлено CODCAGENT Number,
-- в OTCN_SALDO TIP Varchar2(3), CODCAGENT Number
--CURSOR SALDO IS
--   SELECT s.acc, s.nls, s.kv, s.nbs, s.FDAT, NVL(MOD(s.CODCAGENT,2),1),
--          NVL(s.ost,0), NVL(s.ostq,0), s.tip, s.rnk
--   FROM OTCN_SALDO s;

------------------------------------------------------------------
CURSOR BaseL IS
    SELECT kodp, nbuc, SUM(znap)
    FROM RNBU_TRACE
    WHERE userid=userid_
    GROUP BY kodp, nbuc;
-----------------------------------------------------------------------------
PROCEDURE p_ins(p_dat_ DATE, p_tp_ VARCHAR2, p_nls_ VARCHAR2,p_nbs_ VARCHAR2,
  		p_kv_ SMALLINT, p_rez_ VARCHAR2, p_znap_ VARCHAR2) IS
                kod_ VARCHAR2(10);

BEGIN
   IF LENGTH(Trim(p_tp_))=1 THEN
      IF p_kv_=980 THEN
         kod_:='0' ;
      ELSE
         kod_:='1' ;
      END IF ;
   ELSE
      kod_:= '';
   END IF;

   kod_:= p_tp_ || kod_ || p_nbs_ || LPAD(p_kv_,3,'0') || p_rez_ ;

   IF LENGTH(Trim(p_tp_))>1 THEN
      flag_ := F_Is_Est(p_nls_, p_kv_);
      IF flag_=1 AND mfo_<>315568 and mfou_ not in (300465) THEN
         kod_:= p_tp_ || p_nbs_ || '980' || p_rez_ ;
      END IF;
   END IF;

   INSERT INTO RNBU_TRACE
            (nls, kv, odate, kodp, znap, nbuc)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, nbuc_);
END;
-----------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
--SELECT id INTO userid_ FROM STAFF WHERE UPPER(logname)=UPPER(USER);
userid_ := user_id;
--DELETE FROM RNBU_TRACE WHERE userid = userid_;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
pr_:=0;
-- SERG:
mfo_:=gl.aMFO;
if mfo_ is null then
    mfo_ := f_ourmfo_g;
end if;

-- МФО "родителя"
BEGIN
   SELECT NVL(trim(mfou), mfo_)
      INTO mfou_
   FROM BANKS
   WHERE mfo = mfo_;
EXCEPTION WHEN NO_DATA_FOUND THEN
   mfou_ := mfo_;
END;
------------------------------------------------------------------------
--- специфика банка "Ажио"  (c 11.03.2005 для всех банков)
--   tsql_ := 'begin '||
--   'IF dat_next_u(:d,1) = bankdate '||
--   'AND to_char(:d,''MM'') <> to_char(bankdate,''MM'')  THEN '||
--   'delete from tmp_customer; '||
--   'insert into tmp_customer '||
--   'select RNK, CUSTTYPE, COUNTRY, NMK, CODCAGENT, PRINSIDER, '||
--   'OKPO, C_REG, C_DST, DATE_ON, DATE_OFF, CRISK, '||
--   'ISE, FS, OE, VED, SED, MB '||
--   'from customer; '||
--   'END IF; '||
--   'end; ';

--   EXECUTE IMMEDIATE tsql_ USING dat_;
------------------------------------------------------------------------
--gl.p_pvp(null,dat_);

--FOR c IN (SELECT kv FROM tabval WHERE kv<>980) LOOP
--   p_rev(c.kv,dat_);
--END LOOP;

-- в процедуре от 22.09.2005 выполнялись переоценки валютной позиции и
-- переоценка остатков валютных счетов, а 17.01.2006 ее исключили
-- 21.02.2008
-- оставляю переоценку по просьбе банка Демарк (353575)
-- банков СЭБ(300175), УПБ(300205), Сбербанк(300465)

-- SERG: закомментрировал временно !!!
/*
if mfo_ in (300175, 300205, 300465, 353575) then
   gl.p_pvp(null,dat_);

   FOR c IN (SELECT kv FROM tabval WHERE kv<>980) LOOP
      p_rev(c.kv,dat_);
   END LOOP;
end if;
*/

-- определение начальных параметров (код области или МФО или подразделение)
P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);

--- удаление информации из табл. otcn_saldo
--- наполнение счетов (в том числе счетов тех.переоценки) и
--- их остатков (номиналы+эквиваленты)
---DELETE FROM OTCN_SALDO WHERE odate=Dat_;
--EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_SALDO';

--sql_acc_ := 'select r020 from kl_r020 where prem=''КБ '' and f_01=''1''';
-- 04.02.2008 вместо классификатора KL_R020 будем использовать KOD_R020
sql_acc_ := 'select r020 from kod_r020 where trim(prem)=''КБ'' and a010=''01'' ';

--sql_acc_ := 'select r020 from kl_r020 where prem=''КБ '' and f_01=''1'') or '||
--            '(nbs is null and substr(nls,1,4) in
--             (select r020 from kl_r020 where prem=''КБ '' and f_01=''1'')';

ret_ := F_Pop_Otcn(Dat_, 1, sql_acc_);

--- формирование протокола в табл. RBNU_TRACE
OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_, nls_, kv_, nbs_, data_, re_, Ostn_, Ostq_,
                    tips_, rnk_ ;
   EXIT WHEN SALDO%NOTFOUND;

   if mfou_ not in ('300465') then
      IF sheme_ = 'G' AND (tips_<>'T00' AND tips_<>'T0D') AND typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;
   else
      nbuc_ := nbuc1_;
   end if;

   IF tipost_='R' THEN
      BEGIN
         SELECT NVL(SUM(p.s*DECODE(p.DK,0,-1,1,1,0)),0) INTO Dose_
         FROM OPER o, OPLDOK p
         WHERE o.REF  = p.REF  AND
               p.FDAT = dat_   AND
               o.SOS  = 5      AND
               p.acc  = acc_   AND
               (o.tt  LIKE  'ZG%' OR
               ((SUBSTR(o.nlsa,1,1) IN ('6','7') AND
                 SUBSTR(o.nlsb,1,4) IN ('5040','5041')) OR
                (SUBSTR(o.nlsa,1,4) IN ('5040','5041') AND
                SUBSTR(o.nlsb,1,1) IN ('6','7'))));
      EXCEPTION WHEN NO_DATA_FOUND THEN
         Dose_:=0;
      END;
      Ostn_:=Ostn_-Dose_;
   END IF;

--   pr_accc:=0;

--   if nbs_ is not null then
--      BEGIN
--         SELECT count(*) INTO pr_accc
--         FROM otcn_saldo a, accounts s
--         WHERE s.accc=acc_ and s.accc=a.acc and s.nbs is null;
--      EXCEPTION WHEN NO_DATA_FOUND THEN
--         pr_accc:=0;
--      END ;
--   end if;

--   if (nbs_ is null) or (pr_accc=0 and nbs_ is not null) then
--      if nbs_ is null then
--         nbs_:=substr(nls_,1,4);
--      end if;

      IF Ostn_<>0 THEN
         dk_:=Iif_N(Ostn_,0,'1','2','2');
         p_ins(data_, dk_, nls_, nbs_, kv_, TO_CHAR(2-re_), TO_CHAR(ABS(Ostn_)));
      END IF;

      IF Ostq_<>0 THEN
         dk_:=Iif_N(Ostq_,0,'1','2','2')||'0';
         p_ins(data_, dk_, nls_, nbs_, kv_, TO_CHAR(2-re_), TO_CHAR(ABS(Ostq_)));
      END IF;
--   end if;

END LOOP;
CLOSE SALDO;
---------------------------------------------------------------------
-- по просьбе ОПЕРУ СБ для счетов тех.переоценки изменяем код валюты на 978
-- при отсутствии номинала для данной валюты с 01.03.2008
IF mfou_ in (300465) and Dat_ >= to_date('01032008','ddmmyyyy') then
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

-- по просьбе Ровно СБ для счетов тех.переоценки изменяем код валюты на 978
-- при отсутствии номинала для данной валюты с 01.03.2008
IF mfou_ in (300465) and Dat_ >= to_date('01032008','ddmmyyyy') then

   kodp_ := null;

   for k in (select nls, kv, kodp
             from rnbu_trace
             where nls LIKE '9910_001%'
               and kv!=980
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
         END IF;
      END IF;

   end loop;

END IF;
---------------------------------------------------
DELETE FROM TMP_NBU WHERE kodf=kodf_ AND datf= Dat_;
---------------------------------------------------
--- формирование файла в табл. TMP_NBU
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   IF SUBSTR(kodp_,7,3)='980' OR SUBSTR(kodp_,2,1)<>'1' THEN
      b_:=znap_;
   ELSE
      dig_:=F_Ret_Dig(TO_NUMBER(SUBSTR(kodp_,7,3)));
      b_:=TO_CHAR(ROUND(TO_NUMBER(znap_)/dig_,0));
   END IF;

   INSERT INTO TMP_NBU
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        (kodf_, Dat_, kodp_, b_, nbuc_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
P_Ch_File01('01',dat_,userid_);
--------------------------------------------------------
END P_F01_Nn;
/
show err;

PROMPT *** Create  grants  P_F01_NN ***
grant EXECUTE                                                                on P_F01_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F01_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
