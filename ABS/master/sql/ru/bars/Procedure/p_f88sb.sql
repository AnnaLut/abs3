

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F88SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F88SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F88SB (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   :	otcn.sql
% DESCRIPTION :	ќтчетность —берЅанка: формирование файлов
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     : 30.04.2011 (09.03.2011, 13.01.2010)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
30.04.2011 - добавил†acc,tobo в протокол
09.03.2011 - в поле комментарий вносим код TOBO и название счета
11.01.2010 - новый годовой файл
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
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
kodp_   Varchar2(19);
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
r020_   Varchar2(4);
ob22_   Varchar2(2);
dk_     Char(1);
f88_    Number;
userid_ Number;
mfo_    varchar2(12);
tobo_   accounts.tobo%TYPE;
nms_    accounts.nms%TYPE;
comm_   rnbu_trace.comm%TYPE;

---ќстатки на отчетную дату (грн. + валюта)
CURSOR SaldoASeekOstf IS
   SELECT /* + INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */
         a.acc, a.nls, a.kv, a.fdat, a.nbs, a.ostf-a.dos+a.kos,
         a.tobo, a.nms,
         NVL(trim(sp.r020_fa),'0000'), NVL(trim(sp.p080),'0000'),
         NVL(trim(sp.ob88),'0000'), NVL(trim(sp.ob22),'00')
---         GL.P_ICURVAL(a.kv, a.ostf-a.dos+a.kos, Dat_)
   FROM  (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos, s.tobo, s.nms
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc     AND
              (s.acc,aa.fdat) =
               (select c.acc,max(c.fdat)
                from saldoa c
                where s.acc=c.acc and c.fdat <= Dat_
                group by c.acc)) a,
              (select distinct r020
               from sb_p088
               where d_close is null) k, specparam_int sp
   WHERE a.kv=980
     and a.nbs=k.r020
     and a.acc=sp.acc(+);

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
   SELECT /* + INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */
          a.acc, a.nls, a.kv, a.nbs, SUM(s.dos), SUM(s.kos),
          a.tobo, a.nms,
          NVL(trim(sp.r020_fa),'0000'), NVL(trim(sp.p080),'0000'),
          NVL(trim(sp.ob88),'0000'), NVL(trim(sp.ob22),'00')
   FROM saldoa s, accounts a,
        (select distinct r020
         from sb_p088
         where d_close is null) k,
        specparam_int sp
   WHERE s.fdat between Dat1_ AND Dat_
     and a.acc=s.acc
     and a.kv=980
     and a.nbs=k.r020
     and a.acc=sp.acc(+)
   GROUP BY a.acc, a.nls, a.kv, a.nbs, a.tobo, a.nms, sp.r020_fa, sp.p080, sp.ob88, sp.ob22 ;

---ќбороты (по валюте эквиваленты)
---CURSOR SaldoBOBQ IS
---   SELECT a.acc, a.nls, a.kv, a.nbs, SUM(s.dos), SUM(s.kos)
---   FROM saldob s, accounts a, sb_p085 k
---   WHERE s.fdat > Dat1_                AND
---         s.fdat<= Dat_                 AND
---         a.acc=s.acc                   AND
---         a.nbs=k.r020
--  GROUP BY a.acc, a.nls, a.kv, a.nbs ;

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
mfo_ := F_OURMFO();

Dat1_ := TRUNC(Dat_, 'MM');
-- установил 11.01.2010 т.к. оказалось что файл квартальный
Dat1_ := TRUNC(add_months(Dat_,-2),'MM');
Dat2_ := TRUNC(Dat_ + 28);
-------------------------------------------------------------------
-- ќстатки (грн. + валюта номиналы) --
OPEN SaldoASeekOstf;
LOOP
   FETCH SaldoASeekOstf INTO acc_, nls_, kv_, data_, Nbs_, Ostn_, tobo_, nms_,
                             r020_, pp_, zz_, ob22_ ;
   EXIT WHEN SaldoASeekOstf%NOTFOUND;

   f88_:=1 ;
   comm_ := '';

   IF f88_ >0 and Ostn_<>0 THEN
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

      --BEGIN
      --   SELECT NVL(r020_fa,'0000'), NVL(p080,'0000'),
      --          NVL(ob88,'0000'), NVL(ob22,'00')
      --      INTO r020_, pp_, zz_, ob22_
      --   FROM specparam_int
      --   WHERE acc=acc_ ;
      --EXCEPTION WHEN NO_DATA_FOUND THEN
      --   r020_ := '0000';
      --   pp_ := '0000' ;
      --   zz_ := '0000' ;
      --   ob22_ := '00';
      --END ;

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

      kodp_:=dk_ || nbs_ || pp_ || r020_ || ob22_ || zz_ ;
      znap_:=TO_CHAR(ABS(Ostn_));
      INSERT INTO rnbu_trace         -- ќстатки в номинале валюты
              (nls, kv, odate, kodp, znap, acc, comm, tobo)
      VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_) ;
   END IF;
END LOOP;
CLOSE SaldoASeekOstf;
--------------------------------------------------------------------
-- ќстатки (валюта эквиваленты) --
---OPEN SaldoBQ;
---LOOP
---   FETCH SaldoBQ INTO acc_, nls_, kv_, data_, Nbs_, Ostn_ ;
---   EXIT WHEN SaldoBQ%NOTFOUND;

---   SELECT count(*) INTO f85_ FROM sb_p085 WHERE r020_fa=nbs_ ;
---   f85_:=1 ;

---   s0000_:= '0' ;
---   s0009_:= '0' ;

---   IF f85_>0 and Ostn_<>0 THEN
---      BEGIN
---         SELECT NVL(p080,'0000'), NVL(ob22,'00'), NVL(r020_fa,'0000')
---         INTO pp_, zz_, nbs1_
---         FROM specparam_int
---         WHERE acc=acc_ ;
---      EXCEPTION WHEN NO_DATA_FOUND THEN
---         pp_ := '0000' ;
---         zz_ := '00' ;
---         nbs1_:= '0000' ;
---      END ;

---      BEGIN
---         SELECT s0000, s0009 INTO s0000_, s0009_
---        FROM tabval WHERE kv=kv_ and (s0000=nls_ or s0009=nls_) ;
---      EXCEPTION WHEN NO_DATA_FOUND THEN
---         s0000_ := '0' ;
---         s0009_ := '0' ;
---      END ;

---      dk_:=IIF_N(Ostn_,0,'1','2','2');
---      kodp_:=dk_ || pp_ || nbs1_ || zz_ ;
---      znap_:=TO_CHAR(ABS(Ostn_));
---      INSERT INTO rnbu_trace         -- ќстатки в эквиваленте валюты
---              (nls, kv, odate, kodp, znap)
---      VALUES  (nls_, kv_, data_, kodp_, znap_) ;
---   END IF;
---END LOOP;
---CLOSE SaldoBQ;
-----------------------------------------------------------------------------
-- ќбороты текущие (грн. + вал. номиналы ) --
OPEN SaldoASeekOs;
LOOP
   FETCH SaldoASeekOs INTO acc_, nls_, kv_, Nbs_, Dosn_, Kosn_, tobo_, nms_, r020_, pp_, zz_, ob22_;
   EXIT WHEN SaldoASeekOs%NOTFOUND;

   f88_:=1 ;
   comm_ := '';

   IF f88_>0 and (Dosn_ > 0 OR Kosn_ > 0) THEN
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

      --BEGIN
      --   SELECT NVL(r020_fa,'0000'), NVL(p080,'0000'),
      --          NVL(ob88,'0000'), NVL(ob22,'00')
      --      INTO r020_, pp_, zz_, ob22_
      --   FROM specparam_int
      --   WHERE acc=acc_ ;
      --EXCEPTION WHEN NO_DATA_FOUND THEN
      --   r020_ := '0000';
      --   pp_ := '0000' ;
      --   zz_ := '0000' ;
      --   ob22_ := '00';
      --END ;

      IF Kosn_ > 0 THEN

         if mfo_ = 300465 then
            kodp_:='5' || nbs_ || pp_ || r020_ || ob22_ || zz_ ;
         else
            kodp_:='6' || nbs_ || pp_ || r020_ || ob22_ || zz_ ;
         end if;

         znap_:=TO_CHAR(Kosn_) ;
         INSERT INTO rnbu_trace     -- ƒт. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
      END IF;

      IF Dosn_ > 0 THEN

         if mfo_ = 300465 then
            kodp_:='6' || nbs_ || pp_ || r020_ || ob22_ || zz_ ;
         else
            kodp_:='5' || nbs_ || pp_ || r020_ || ob22_ || zz_ ;
         end if;

         znap_:=TO_CHAR(Dosn_);
         INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
      END IF;
   END IF;
END LOOP;
CLOSE SaldoASeekOs;
-------------------------------------------------------------------------
-- ќбороты текущие (вал. эквиваленты ) --
---OPEN SaldoBOBQ;
---LOOP
---   FETCH SaldoBOBQ INTO acc_, nls_, kv_, nbs_, Dose_, Kose_ ;
---   EXIT WHEN SaldoBOBQ%NOTFOUND;

---   SELECT count(*) INTO f85_ FROM sb_p085 WHERE r020_fa=nbs_ ;
---   f85_:=1 ;

---  s0000_:='0' ;
---   s0009_:='0' ;

---   IF f85_>0 and (Dose_ > 0 OR Kose_ > 0) THEN
---      BEGIN
---         SELECT NVL(p080,'0000'), NVL(ob22,'00'), NVL(r020_fa,'0000')
---         INTO pp_, zz_, nbs1_
---         FROM specparam_int
---         WHERE acc=acc_ ;
---      EXCEPTION WHEN NO_DATA_FOUND THEN
---         pp_ := '0000' ;
---         zz_ := '00' ;
---         nbs1_:= '0000' ;
---      END ;

---      BEGIN
---         SELECT s0000, s0009 INTO s0000_, s0009_
---         FROM tabval WHERE kv=kv_ and (s0000=nls_ or s0009=nls_) ;
---      EXCEPTION WHEN NO_DATA_FOUND THEN
---         s0000_ := '0' ;
---         s0009_ := '0' ;
---      END ;
---      IF Dose_ > 0 THEN
---         kodp_:='5' || pp_ || nbs1_ || zz_ ;
---         znap_:=TO_CHAR(Dose_) ;
---         INSERT INTO rnbu_trace         -- ƒб. обороты в эквиваленте
---                 (nls, kv, odate, kodp, znap)
---         VALUES  (nls_, kv_, dat_, kodp_, znap_) ;
---      END IF;

---      IF Kose_ > 0 THEN
---         kodp_:='6' || pp_ || nbs1_ || zz_ ;
---         znap_:=TO_CHAR(Kose_) ;
---         INSERT INTO rnbu_trace         --  р. обороты в эквиваленте
---                 (nls, kv, odate, kodp, znap)
---         VALUES  (nls_, kv_, dat_, kodp_, znap_) ;
---      END IF;
---   END IF;
---END LOOP;
---CLOSE SaldoBOBQ;
---------------------------------------------------
DELETE FROM tmp_irep where kodf='88' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap)
   VALUES
        ('88', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_f88sb;
/
show err;

PROMPT *** Create  grants  P_F88SB ***
grant EXECUTE                                                                on P_F88SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F88SB         to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F88SB.sql =========*** End *** =
PROMPT ===================================================================================== 
