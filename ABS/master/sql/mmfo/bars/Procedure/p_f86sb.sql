

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F86SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F86SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F86SB (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   :    otcn.sql
% DESCRIPTION :    ќтчетность —берЅанка: формирование файлов
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     : 25.12.2012 (15.09.2012,30.04.2011,18.03.2010,11.01.2010)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
25.12.2012 - отбираем строго по кл-ру SB_P086 существующие значени¤
             бал.счета и спецпараметра P080 и полей R020 и P080
             дл¤ vќ” как дл¤ всех –”
             убрали ненужные индексы
15.09.2012 - формируем в разрезе кодов территорий
30.04.2011 - добавил†acc,tobo в протокол
18.03.2010 - добавил условие дл¤ SB_P086 "or d_close>=Dat1_"
11.01.2010 - т.к. файл квартальный то изменил отбор оборотов с мес¤ца на
             квартал (переменна¤ Dat1_)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_   varchar2(2) := '86';
acc_    Number;
acc1_   Number;
acc2_   Number;
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
kodp_   Varchar2(13);
znap_   Varchar2(30);
Kv_     SMALLINT;
Vob_    SMALLINT;
Nbs_    Varchar2(4);
Nbs1_   Varchar2(4);
nls_    Varchar2(15);
s0000_  Varchar2(15);
s0009_  Varchar2(15);
data_   Date;
zz_     Varchar2(4);
pp_     Varchar2(4);
dk_     Char(1);
f86_    Number;
userid_ Number;
mfo_    varchar2(12);
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;
typ_    Number;
nbuc1_  VARCHAR2(12);
nbuc_   VARCHAR2(12);

---ќстатки на отчетную дату (грн. + валюта)
CURSOR SaldoASeekOstf IS
   SELECT /*  INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */ 
         a.acc, a.nls, a.kv, a.fdat, a.nbs, a.ostf-a.dos+a.kos,
         a.tobo, a.nms
---         GL.P_ICURVAL(a.kv, a.ostf-a.dos+a.kos, Dat_)
   FROM  (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos, s.tobo, s.nms
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc     AND
               aa.fdat = (select max(c.fdat)
                          from saldoa c
                          where c.acc=aa.acc and c.fdat <= Dat_)
                         ) a,
              (select distinct r020,p080
               from sb_p086
               where d_close is null or d_close>=Dat1_) k,
                specparam_int i
   WHERE a.kv=980           AND
         a.nbs=k.r020       AND
         a.acc=i.acc(+)     AND
         i.p080=k.p080    ;

---ќстатки на отчетную дату (сч. тех. переоценки + эквиваленты)
---CURSOR SaldoBQ IS
---   SELECT  a.acc, a.nls, a.kv, a.fdat, a.nbs, a.ostf-a.dos+a.kos
---   FROM  (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
---         aa.dos, aa.kos
---         FROM saldob aa, accounts s
---         WHERE aa.acc=s.acc     AND
---              (s.acc,aa.fdat) =
---               (select c.acc,max(c.fdat)
---                from saldob c
---                where s.acc=c.acc and c.fdat <= Dat_
---                group by c.acc)) a, sb_p085 k
---   WHERE a.acc is not null  AND
---         a.nbs=k.r020 ;

---ќбороты (по грн. + по валюте номиналы)
CURSOR SaldoASeekOs IS
   SELECT /*  INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */ 
      a.acc, a.nls, a.kv, a.nbs, SUM(s.dos), SUM(s.kos), a.tobo, a.nms
     FROM saldoa s, accounts a, specparam_int i,
        (select distinct r020,p080
         from sb_p086
         where d_close is null or d_close>=Dat1_) k
   WHERE s.fdat between Dat1_ AND Dat_  AND
         a.acc=s.acc                    AND
         a.kv=980                       AND
         a.nbs=k.r020                   AND
         a.acc=i.acc(+)                 AND
         i.p080=k.p080
   GROUP BY a.acc, a.nls, a.kv, a.nbs, a.tobo, a.nms ;

CURSOR BaseL IS
    SELECT kodp, nbuc, SUM (znap)
    FROM rnbu_trace
    WHERE userid=userid_
    GROUP BY kodp, nbuc;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
mfo_ := F_OURMFO();

-- было до 11.01.2010
--Dat1_ := TRUNC(Dat_ - TO_NUMBER(TO_CHAR(Dat_,'DD')));
-- установил 11.01.2010 т.к. оказалось что файл квартальный

Dat1_ := TRUNC(add_months(Dat_,-2),'MM');

Dat2_ := TRUNC(Dat_ + 28);

-- определение начальных параметров
P_Proc_Set_Int(kodf_,sheme_,nbuc1_,typ_);
-------------------------------------------------------------------
-- ќстатки (грн. + валюта номиналы) --
OPEN SaldoASeekOstf;
LOOP
   FETCH SaldoASeekOstf INTO acc_, nls_, kv_, data_, Nbs_, Ostn_, tobo_, nms_ ;
   EXIT WHEN SaldoASeekOstf%NOTFOUND;

---   SELECT count(*) INTO f86_ FROM sb_p086 WHERE r020=nbs_ ;
   f86_:=1 ;

   IF f86_ >0 and Ostn_<>0 THEN

      IF typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

      BEGIN
         SELECT NVL(p080,'0000'), NVL(ob88,'0000')
            INTO pp_, zz_
         FROM specparam_int
         WHERE acc=acc_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         pp_ := '0000' ;
         zz_ := '0000' ;
      END ;

--      BEGIN
--         SELECT NVL(ob88,'0000') INTO zz_
--         FROM sb_ob88
--         WHERE r020=nbs_ ;
--      EXCEPTION WHEN NO_DATA_FOUND THEN
--         zz_ := '0000' ;
--      END ;

      if mfo_ = 300465 then
         dk_:=IIF_N(Ostn_,0,'2','1','1');
      else
         dk_:=IIF_N(Ostn_,0,'1','2','2');
      end if;

      kodp_:=dk_ || nbs_ || pp_ || zz_ ;
      znap_:=TO_CHAR(ABS(Ostn_));
      INSERT INTO rnbu_trace         -- ќстатки в номинале валюты
              (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
      VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
   END IF;
END LOOP;
CLOSE SaldoASeekOstf;
-----------------------------------------------------------------------------
-- ќбороты текущие (грн. + вал. номиналы ) --
OPEN SaldoASeekOs;
LOOP
   FETCH SaldoASeekOs INTO acc_, nls_, kv_, Nbs_, Dosn_, Kosn_, tobo_, nms_ ;
   EXIT WHEN SaldoASeekOs%NOTFOUND;

---   SELECT count(*) INTO f86_ FROM sb_p086 WHERE r020=nbs_ ;
   f86_:=1 ;

   IF f86_>0 and (Dosn_ > 0 OR Kosn_ > 0) THEN

      IF typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

      BEGIN
         SELECT NVL(p080,'0000'), NVL(ob88,'0000')
            INTO pp_, zz_
         FROM specparam_int
         WHERE acc=acc_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         pp_ := '0000' ;
         zz_ := '0000' ;
      END ;

--      BEGIN
--         SELECT NVL(ob88,'0000') INTO zz_
--         FROM sb_ob88
--         WHERE r020=nbs_ ;
--      EXCEPTION WHEN NO_DATA_FOUND THEN
--         zz_ := '0000' ;
--      END ;

      IF Kosn_ > 0 THEN
         --if mfo_ = 300465 then
         --   kodp_:='5' || nbs_ || pp_ || zz_ ;
         --else
         --   kodp_:='6' || nbs_ || pp_ || zz_ ;
         --end if;

         kodp_:='6' || nbs_ || pp_ || zz_ ;
         znap_:=TO_CHAR(Kosn_) ;
         INSERT INTO rnbu_trace     -- ?т. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
      END IF;

      IF Dosn_ > 0 THEN
         --if mfo_ = 300465 then
         --   kodp_:='6' || nbs_ || pp_ || zz_ ;
         --else
         --   kodp_:='5' || nbs_ || pp_ || zz_ ;
         --end if;

         kodp_:='5' || nbs_ || pp_ || zz_ ;
         znap_:=TO_CHAR(Dosn_);
         INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
      END IF;
   END IF;
END LOOP;
CLOSE SaldoASeekOs;
-------------------------------------------------------------------------
----------------------------------------------------
DELETE FROM tmp_irep where kodf='86' and datf= dat_;
----------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, nbuc, znap)
   VALUES
        ('86', Dat_, kodp_, nbuc_, znap_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_f86sb;
/
show err;

PROMPT *** Create  grants  P_F86SB ***
grant EXECUTE                                                                on P_F86SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F86SB         to NALOG;
grant EXECUTE                                                                on P_F86SB         to RPBN002;
grant EXECUTE                                                                on P_F86SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F86SB.sql =========*** End *** =
PROMPT ===================================================================================== 
