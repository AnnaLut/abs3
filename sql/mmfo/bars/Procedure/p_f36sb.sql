

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F36SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F36SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F36SB (Dat_ DATE ) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   :	Процедура формирования файла @36 для СБ
% DESCRIPTION :	Отчетность СберБанка: формирование файлов
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     : 30.04.2011 (14.03.2011,28.10.2009,27.10.2009,26.10.2009)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
30.04.2011 - добавил acc,tobo в протокол
14.03.2011 - в поле комментарий вносим код TOBO и название счета
03.11.2009 - установил Dat1_=to_date('01102009','ddmmyyyy')
28.10.2009 - при формировании показателей количества для OB22='05'
             заменяем OB22 на значение "22"
27.19.2009 - не будем формировать код DD='02','05','06' для OB22='05'
26.10.2009 - первый вариант процедуры
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
acc_    Number;
acc1_   Number;
acc2_   Number;
pr_     Number;
pr_pp   Number;
daos_   Date;
dat1_   Date;
dat2_   Date;
Dosn_   DECIMAL(24);
Dose_   DECIMAL(24);
Kosn_   DECIMAL(24);
Kose_   DECIMAL(24);
se_     DECIMAL(24);
sn_     DECIMAL(24);
Ostn_   DECIMAL(24);
Oste_   DECIMAL(24);
kodp_   varchar2(12);
znap_   varchar2(30);
Kv_     SMALLINT;
Nbs_    varchar2(4);
nls_    varchar2(15);
data_   date;
zz_     Varchar2(2);
ob22_   Varchar2(2);
dk_     char(1);
f36_    Number;
userid_ Number;
mfo_    Number;
tobo_   accounts.tobo%TYPE;
nms_    accounts.nms%TYPE;
comm_   rnbu_trace.comm%TYPE;

CURSOR SCHETA IS
    SELECT s.acc
    FROM accounts s, sb_r020 k
    WHERE s.nbs=k.r020    AND
          k.f_37='1' ;

---Остатки на отчетную дату (грн. + валюта)
CURSOR SaldoASeekOstf IS
   SELECT s.acc, s.nls, s.kv, s.daos, aa.fdat, s.nbs, NVL(trim(sp.ob22),'00'),
          aa.ostf-aa.dos+aa.kos, s.tobo, s.nms
         FROM accounts s, saldoa aa, specparam_int sp
         WHERE s.nbs in ('2620','2635')
           AND s.kv in (840,980)
           AND aa.acc=s.acc
           AND aa.fdat = (select max(c.fdat)
                          from saldoa c
                          where c.acc=aa.acc
                            and c.fdat <= Dat_)
           AND aa.ostf-aa.dos+aa.kos<>0
           AND s.acc = sp.acc(+);

---Обороты (по грн. + по валюте номиналы)
CURSOR SaldoASeekOs IS
   SELECT /* + INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */
          a.acc, a.nls, a.kv, a.daos, a.nbs, NVL(trim(sp.ob22),'00'),
          SUM(s.dos), SUM(s.kos), a.tobo, a.nms
   FROM accounts a, saldoa s, specparam_int sp
   WHERE a.nbs in ('2620','2635')
     AND a.kv in (840,980)
     AND s.fdat >= Dat1_
     AND s.fdat<= Dat_
     AND s.acc=a.acc
     AND s.dos+s.kos<>0
     AND a.acc = sp.acc(+)
   GROUP BY a.acc, a.nls, a.kv, a.daos, a.nbs, NVL(trim(sp.ob22),'00'), a.tobo, a.nms;

CURSOR BaseL IS
    SELECT kodp, SUM (znap)
    FROM rnbu_trace
    WHERE userid=userid_
    GROUP BY kodp;

BEGIN
-------------------------------------------------------------------
--SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
userid_ := user_id;
--DELETE FROM RNBU_TRACE WHERE userid = userid_;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
mfo_:=gl.aMFO;
if mfo_ is null then
    mfo_ := f_ourmfo_g;
end if;

Dat1_ := TRUNC(Dat_ - TO_NUMBER(TO_CHAR(Dat_,'DD')));

Dat1_ := to_date('01102009','ddmmyyyy');
Dat2_ := TRUNC(Dat_ + 28);

-------------------------------------------------------------------
SELECT count(*) into f36_
FROM tmp_irep
WHERE kodf='36' and datf=Dat_ ;
----------------------------------------------------------------------------
-- Остатки (грн. + валюта номиналы) --
OPEN SaldoASeekOstf;
LOOP
   FETCH SaldoASeekOstf INTO acc_, nls_, kv_, daos_, data_, Nbs_, zz_, Ostn_,
                             tobo_, nms_ ;
   EXIT WHEN SaldoASeekOstf%NOTFOUND;

---занесение кодов спецпараметров по новым счетам
----------------------------------------------------------------------------
   IF Ostn_<>0 THEN
      comm_ := '';
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
      --BEGIN
      --   SELECT NVL(ob22,'00') into zz_
      --   FROM specparam_int
      --   WHERE acc=acc_ ;
      --   EXCEPTION WHEN NO_DATA_FOUND THEN
      --   zz_:='00';
      --END ;

      if (nbs_='2620' and zz_ in ('05','22','26','00')) OR
         (nbs_='2635' and zz_ in ('27')) then
         dk_:=IIF_N(Ostn_,0,'1','2','2');
         IF Kv_=980 THEN
            kodp_:='1' || '02' ;
         ELSE
            kodp_:='1' || '12' ;
         END IF ;

         kodp_:=kodp_ || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
         znap_:=TO_CHAR(ABS(Ostn_));

         if zz_ != '05' then
            INSERT INTO rnbu_trace         -- Остатки в номинале валюты
                    (nls, kv, odate, kodp, znap, acc, comm, tobo)
            VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_) ;
         end if;

         if zz_ = '05' then
            kodp_:='3' || '00' || Nbs_ || '22' || lpad(Kv_,3,'0') ;
         else
            kodp_:='3' || '00' || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
         end if;
         znap_:='1';

         INSERT INTO rnbu_trace         -- Количество счетов по 2620 2635
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_) ;

      end if;
   END IF;
END LOOP;
CLOSE SaldoASeekOstf;
--------------------------------------------------------------------
-- Обороты текущие (грн. + вал. номиналы ) --
OPEN SaldoASeekOs;
LOOP
   FETCH SaldoASeekOs INTO acc_, nls_, kv_, daos_, Nbs_, zz_, Dosn_, Kosn_,
                           tobo_, nms_ ;
   EXIT WHEN SaldoASeekOs%NOTFOUND;

   IF Dosn_ > 0 OR Kosn_ > 0 THEN
      comm_ := '';
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
      --BEGIN
      --   SELECT NVL(ob22,'00') into zz_
      --   FROM specparam_int
      --   WHERE acc=acc_ ;
      --   EXCEPTION WHEN NO_DATA_FOUND THEN
      --   zz_:='00';
      --END ;

      IF Dosn_ > 0 THEN
         if (nbs_='2620' and zz_ in ('05','22','26','00')) OR
            (nbs_='2635' and zz_ in ('27')) then
            BEGIN
               select ost
                  into ostn_
               from sal
               where fdat=Dat_ and acc=acc_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               ostn_ := 0;
            END;

            IF Kv_=980 THEN
               kodp_:='1' || '05' || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
            ELSE
               kodp_:='1' || '15' || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
            END IF ;
            znap_:=TO_CHAR(Dosn_);

            if zz_ != '05' then
               INSERT INTO rnbu_trace     -- Дб. обороты в номинале валюты (грн.+вал.)
                       (nls, kv, odate, kodp, znap, acc, comm, tobo)
               VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
            end if;

            if ostn_=0 and kosn_ != 0 then
               if zz_ = '05' then
                  kodp_:='5' || '00' || Nbs_ || '22' || lpad(Kv_,3,'0') ;
               else
                  kodp_:='5' || '00' || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
               end if;
               znap_:='1';

               INSERT INTO rnbu_trace         -- Количество счетов по 2620 2635
                    (nls, kv, odate, kodp, znap, acc, comm, tobo)
               VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_) ;
            end if;

            if ostn_ != 0 then
               if zz_ = '05' then
                  kodp_:='6' || '00' || Nbs_ || '22' || lpad(Kv_,3,'0') ;
               else
                  kodp_:='6' || '00' || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
               end if;
               znap_:='1';

               INSERT INTO rnbu_trace         -- Количество счетов по 2620 2635
                    (nls, kv, odate, kodp, znap, acc, comm, tobo)
               VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_) ;
            end if;

         end if;
      END IF;

      IF Kosn_ > 0 THEN
         if (nbs_='2620' and zz_ in ('05','22','26','00')) OR
            (nbs_='2635' and zz_ in ('27')) then

            IF Kv_=980 THEN
               kodp_:='1' || '06' || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
            ELSE
               kodp_:='1' || '16' || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
            END IF ;
            znap_:=TO_CHAR(Kosn_) ;

            if zz_ != '05' then
               INSERT INTO rnbu_trace     -- Кр. обороты в номинале валюты (грн.+вал.)
                       (nls, kv, odate, kodp, znap, acc, comm, tobo)
               VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
            end if;

            if zz_ = '05' then
               kodp_:='4' || '00' || Nbs_ || '22' || lpad(Kv_,3,'0') ;
            else
               kodp_:='4' || '00' || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
            end if;
            znap_:='1';

            INSERT INTO rnbu_trace         -- Количество счетов по 2620 2635
                    (nls, kv, odate, kodp, znap, acc, comm, tobo)
            VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_) ;
         end if;
      END IF;
   END IF;
END LOOP;
CLOSE SaldoASeekOs;
---------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_irep where kodf='36' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap)
   VALUES
        ('36', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_f36sb;
/
show err;

PROMPT *** Create  grants  P_F36SB ***
grant EXECUTE                                                                on P_F36SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F36SB         to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F36SB.sql =========*** End *** =
PROMPT ===================================================================================== 
