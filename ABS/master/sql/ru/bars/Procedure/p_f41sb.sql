

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F41SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F41SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F41SB (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла @41 для Ощадного Банку
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 23.02.2009 (18.10.2005)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
acc_    Number;
acc1_   Number;
accd_   Number;
acck_   Number;
ref_    Number;
dat1_   Date;
dat2_   Date;
Dosnk_  DECIMAL(24);
Dosn_   DECIMAL(24);
Kosnk_  DECIMAL(24);
Kosn_   DECIMAL(24);
se_     DECIMAL(24);
sn_     DECIMAL(24);
Ostn_   DECIMAL(24);
Oste_   DECIMAL(24);
kodp_   Varchar2(11);
znap_   Varchar2(30);
Kv_     SMALLINT;
Vob_    SMALLINT;
Nbs_    Varchar2(4);
nls_    Varchar2(15);
nlsk_   Varchar2(15);
s0000_  Varchar2(15);
s0009_  Varchar2(15);
data_   date;
zz_     Varchar2(2);
kk_     Varchar2(4);
dk_     char(1);
userid_ Number;

---Остатки на отчетную дату (грн. + валюта)
CURSOR SaldoASeekOstf IS
   SELECT /* + INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */
         a.acc, a.nls, a.kv, a.fdat, a.nbs, '00', a.ostf-a.dos+a.kos
---         GL.P_ICURVAL(a.kv, a.ostf-a.dos+a.kos, Dat_)
   FROM  (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc     AND
              (s.acc,aa.fdat) =
               (select c.acc,max(c.fdat)
                from saldoa c
                where s.acc=c.acc and c.fdat <= Dat_
                group by c.acc)) a, kl_f3_29_int k
   WHERE a.acc is not null  AND
         a.kv=980           AND
         a.nbs=k.r020       AND
         k.kf='41' ;

---Остатки на отчетную дату (сч. тех. переоценки + эквиваленты)
CURSOR SaldoBQ IS
   SELECT  a.acc, a.nls, a.kv, a.fdat, a.nbs, '00', a.ostf-a.dos+a.kos
   FROM  (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos
         FROM saldob aa, accounts s
         WHERE aa.acc=s.acc     AND
              (s.acc,aa.fdat) =
               (select c.acc,max(c.fdat)
                from saldob c
                where s.acc=c.acc and c.fdat <= Dat_
                group by c.acc)) a, kl_f3_29_int k
   WHERE a.acc is not null AND
         a.nbs=k.r020      AND
         k.kf='41';
-----------------------------------------------------------------------
--- Корректирующие проводки для счетов отсутствующих в конце месяца ---
CURSOR SaldoAOstfk IS
   SELECT s.acc, s.nls, s.kv, s.daos, s.nbs, '00', NVL(substr(a1.value,1,2),'00'),
---          SUM(DECODE(a.dk, 0, a.s, 0)),
          SUM(DECODE(a.dk, 0, GL.P_ICURVAL(s.kv, a.s, Dat_), 0)),
---          SUM(DECODE(a.dk, 1, a.s, 0))
          SUM(DECODE(a.dk, 1, GL.P_ICURVAL(s.kv, a.s, Dat_), 0))
   FROM  kor_prov a, accounts s, cust_acc ca, customer c,
         operw a1, kl_f3_29_int k
   WHERE s.nbs=k.r020                    AND
         k.kf='41'                       AND
         a.fdat > Dat_                   AND
         a.fdat <= Dat2_                 AND
         a.acc=s.acc                     AND
         s.daos > Dat_                   AND
         a.acc=ca.acc                    AND
         c.rnk=ca.rnk                    AND
         a.vob=96                        AND
         a1.ref(+)=a.ref                 AND
         a1.tag(+)='OB41'
   GROUP BY s.acc, s.nls, s.kv, s.daos, s.nbs, '00', NVL(substr(a1.value,1,2),'00');
-----------------------------------------------------------------------
CURSOR OPL_DOK IS
   SELECT distinct * FROM (
   SELECT o.ref, o.accd, o.nlsd, o.kv, o.fdat,
          o.s*100, o.acck, o.nlsk, substr(o.nlsd,1,4)
   FROM  provodki o, kl_f3_29_int k
   WHERE substr(o.nlsd,1,4)=k.r020  and
         k.kf='41'                  and
         o.tt<>'096'                and
         o.tt<>'099'                and
         o.fdat > Dat1_             and
         o.fdat <= Dat_
UNION ALL
   SELECT o.ref, o.accd, o.nlsd, o.kv, o.fdat,
          o.s*100, o.acck, o.nlsk, substr(o.nlsk,1,4)
   FROM  provodki o, kl_f3_29_int k
   WHERE substr(o.nlsk,1,4)=k.r020  and
         k.kf='41'                  and
         o.tt<>'096'                and
         o.tt<>'099'                and
         o.fdat > Dat1_             and
         o.fdat <= Dat_ ) ;
----------------------------------------------------------------------
--- коррект. проводки для кодов '5' и '6'
CURSOR KOR_PROVODKI IS
    SELECT a.acc, s.nls, s.kv, a.fdat, NVL(substr(a1.value,1,4),'0000'),
           DECODE(a.dk, 0, GL.P_ICURVAL(s.kv, a.s, Dat_), 0),
           DECODE(a.dk, 1, GL.P_ICURVAL(s.kv, a.s, Dat_), 0)
    FROM  kor_prov a, accounts s, operw a1, kl_f3_29_int k
    WHERE a.acc=s.acc                               and
          s.nbs=k.r020                              and
          k.kf='41'                                 and
          a.fdat > Dat_                             and
          a.fdat <= Dat2_                           and
          a1.ref (+) =a.ref                         and
          a1.tag (+)='OB41' ;
---          GROUP BY o.nlsd, o.kv, o.fdat, substr(a1.value,1,2)
----------------------------------------------------------------------
CURSOR BaseL IS
    SELECT kodp, SUM (znap)
    FROM rnbu_trace
    WHERE userid=userid_
    GROUP BY kodp
    ORDER BY kodp;

BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_ - TO_NUMBER(TO_CHAR(Dat_,'DD')));
Dat2_ := TRUNC(Dat_ + 28);
--------------------- Корректирующие проводки  ---------------------
---TRUNCATE TABLE kor_prov ;
DELETE FROM ref_kor ;
INSERT INTO ref_kor (REF, VOB, VDAT)
SELECT ref, vob, vdat
FROM oper
WHERE vob=96 OR vob=99 ;

DELETE FROM kor_prov ;
INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
SELECT o.ref, o.dk, o.acc, o.s, o.fdat, p.vdat, o.sos, p.vob
FROM opldok o, ref_kor p     --- oper p
WHERE o.fdat>Dat1_     AND
      o.fdat<=Dat2_    AND
      o.ref=p.ref      AND
      o.sos=5 ;
---where o.ref=p.ref and p.vob>95 and o.sos=5;
---COMMIT;
-------------------------------------------------------------------
-- Остатки (грн. + валюта номиналы) --
OPEN SaldoASeekOstf;
LOOP
   FETCH SaldoASeekOstf INTO acc_, nls_, kv_, data_, Nbs_, zz_, Ostn_ ;
   EXIT WHEN SaldoASeekOstf%NOTFOUND;

---   IF Ostn_<>0 THEN
--- Отбор корректирующих проводок отчетного месяца
      BEGIN
         SELECT d.acc,
            SUM(DECODE(d.dk, 0, d.s, 0)),
            SUM(DECODE(d.dk, 1, d.s, 0))
         INTO acc1_, Dosnk_, Kosnk_
         FROM  kor_prov d
         WHERE d.acc=acc_                   AND
               d.fdat > Dat_                AND
               d.fdat <= Dat2_              AND
               d.vob = 96
         GROUP BY d.acc ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         Dosnk_ :=0 ;
         Kosnk_ :=0 ;
      END ;

      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc=acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;

      Ostn_:=Ostn_-Dosnk_+Kosnk_ ;

      IF Ostn_<>0 THEN
         dk_:=IIF_N(Ostn_,0,'1','2','2');
         kodp_:=dk_ || nbs_ || zz_ || '0000' ;
         znap_:=TO_CHAR(ABS(Ostn_));
         INSERT INTO rnbu_trace         -- Остатки в номинале валюты
                 (nls, kv, odate, kodp, znap)
         VALUES  (nls_, kv_, data_, kodp_, znap_) ;
      END IF;
---   END IF;
END LOOP;
CLOSE SaldoASeekOstf;
--------------------------------------------------------------------
-- Остатки (валюта эквиваленты) --
OPEN SaldoBQ;
LOOP
   FETCH SaldoBQ INTO acc_, nls_, kv_, data_, Nbs_, zz_, Ostn_ ;
   EXIT WHEN SaldoBQ%NOTFOUND;

   s0000_:= '0' ;
   s0009_:= '0' ;

---   IF Ostn_<>0 THEN
--- Отбор корректирующих проводок отчетного месяца
      BEGIN
         SELECT d.acc,
            SUM(DECODE(d.dk, 0, GL.P_ICURVAL(kv_, d.s, Dat_), 0)),
            SUM(DECODE(d.dk, 1, GL.P_ICURVAL(kv_, d.s, Dat_), 0))
---            SUM(DECODE(d.dk, 0, d.s, 0))
---            SUM(DECODE(d.dk, 1, d.s, 0))
         INTO acc1_, Dosnk_, Kosnk_
         FROM  kor_prov d
         WHERE d.acc=acc_                   AND
               d.fdat > Dat_                AND
               d.fdat <= Dat2_              AND
               d.vob = 96
         GROUP BY d.acc ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         Dosnk_ :=0 ;
         Kosnk_ :=0 ;
      END ;

      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc=acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;

      BEGIN
         SELECT s0000, s0009 INTO s0000_, s0009_
         FROM tabval WHERE kv=kv_ and (s0000=nls_ or s0009=nls_) ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         s0000_ := '0' ;
         s0009_ := '0' ;
      END ;

      Ostn_:=Ostn_-Dosnk_+Kosnk_ ;

      IF Ostn_<>0 THEN
         dk_:=IIF_N(Ostn_,0,'1','2','2');
         kodp_:=dk_ || nbs_ || zz_ || '0000' ;
         znap_:=TO_CHAR(ABS(Ostn_));
         INSERT INTO rnbu_trace         -- Остатки в эквиваленте валюты
                 (nls, kv, odate, kodp, znap)
         VALUES  (nls_, kv_, data_, kodp_, znap_) ;
      END IF;
---   END IF;
END LOOP;
CLOSE SaldoBQ;
-----------------------------------------------------------------------------
--- Остатки сформиров. по корр.проводкам для сч. отсутств. в конце месяца
OPEN SaldoAOstfk;
   LOOP
   FETCH SaldoAOstfk INTO acc_, nls_, kv_, data_, Nbs_, zz_, ref_, Dosn_, Kosn_ ;
   EXIT WHEN SaldoAOstfk%NOTFOUND;

      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc=acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;

--      BEGIN
--         SELECT NVL(substr(value,1,2),'0000') into kk_
--         FROM operw
--         WHERE ref=ref_ ;
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--         kk_:='0000';
--      END ;

---      IF Dosn_<>0 THEN
---         dk_:='5';
---         kodp_:= dk_ || nbs_ || zz_ || kk_ ;
---        znap_:=TO_CHAR(Dosn_);
---         INSERT INTO rnbu_trace         -- Дт обороти
---                (nls, kv, odate, kodp, znap)
---         VALUES  (nls_, kv_, data_, kodp_, znap_) ;
---      END IF;
---      IF Kosn_<>0 THEN
---         dk_:='6';
---         kodp_:= dk_ || nbs_ || zz_ || kk_ ;
---         znap_:=TO_CHAR(Kosn_);
---         INSERT INTO rnbu_trace         -- Кт обороти
---                (nls, kv, odate, kodp, znap)
---         VALUES  (nls_, kv_, data_, kodp_, znap_) ;
---      END IF;

      sn_:=Kosn_-Dosn_ ;
      IF sn_<>0 THEN
         dk_:=IIF_N(sn_,0,'1','2','2');
         kodp_:= dk_ || nbs_ || zz_ || '0000' ;
         znap_:=TO_CHAR(ABS(se_));
         INSERT INTO rnbu_trace         -- _статки _р-. + экв. ва<юты
                (nls, kv, odate, kodp, znap)
         VALUES  (nls_, kv_, data_, kodp_, znap_) ;
      END IF;
END LOOP;
CLOSE SaldoAOstfk;
-----------------------------------------------------------------------------
OPEN OPL_DOK;
LOOP
   FETCH OPL_DOK INTO ref_, accd_, nls_, kv_, data_, sn_, acck_, nlsk_, nbs_ ; --kk_
   EXIT WHEN OPL_DOK%NOTFOUND;

   BEGIN
      SELECT NVL(SUBSTR(value,1,2),'0000') INTO kk_
      FROM operw
      WHERE ref=ref_ and tag='OB41' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      kk_:='0000';
   END ;

   IF sn_>0 and substr(nls_,1,4)=nbs_ THEN
      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc=accd_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;
      kodp_:= '5' || SUBSTR(nls_,1,4) || zz_ || kk_ ;
      znap_:= TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_,znap_);
   END IF;

   IF sn_>0 and substr(nlsk_,1,4)=nbs_ THEN
      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc=acck_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;
      kodp_:= '6' || SUBSTR(nlsk_,1,4) || zz_ || kk_ ;
      znap_:= TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nlsk_, kv_, data_, kodp_,znap_);
   END IF;
END LOOP;
CLOSE OPL_DOK;
----------------------------------------------------------------------
--- обороты по корректирующим проводкам коды '5' и '6'
OPEN KOR_PROVODKI;
LOOP
   FETCH KOR_PROVODKI INTO acc_, nls_, kv_, data_, kk_, Dosn_, Kosn_ ;
   EXIT WHEN KOR_PROVODKI%NOTFOUND;
   IF Dosn_>0 THEN
      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc=acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;
      kodp_:= '5' || SUBSTR(nls_,1,4) || zz_ || kk_ ;
      znap_:= TO_CHAR(Dosn_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_,znap_);
   END IF;

   IF Kosn_>0 THEN
      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc=acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;
      kodp_:= '6' || SUBSTR(nls_,1,4) || zz_ || kk_ ;
      znap_:= TO_CHAR(Kosn_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_,znap_);
   END IF;
END LOOP;
CLOSE KOR_PROVODKI;
---------------------------------------------------
---DELETE FROM tmp_nbu where kodf='41' and datf= dat_;
DELETE FROM tmp_irep where kodf='41' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap)
   VALUES
        ('41', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_f41sb;
/
show err;

PROMPT *** Create  grants  P_F41SB ***
grant EXECUTE                                                                on P_F41SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F41SB         to RPBN002;
grant EXECUTE                                                                on P_F41SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F41SB.sql =========*** End *** =
PROMPT ===================================================================================== 
