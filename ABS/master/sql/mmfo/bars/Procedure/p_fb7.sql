

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FB7.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FB7 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FB7 (Dat_ DATE )  IS
acc_     Number;
acc1_    Number;
dk_      Varchar2(1);
nbs_     Varchar2(4);
nls_     Varchar2(15);
nls1_    Varchar2(15);
r012_    Varchar2(1);
r012n_   Varchar2(1);
r013_    Varchar2(1);
r050_    Varchar2(2);
kod_11   Varchar2(2);
Dat1_    Date;
Dat2_    Date;
Dat3_    Date;
Dat4_    Date;
data_    Date;
kv_      SMALLINT;
sn_      DECIMAL(24);
se_      DECIMAL(24);
Dosek_   DECIMAL(24);
Kosek_   DECIMAL(24);
Dose_    DECIMAL(24);
kodp_    Varchar2(6);
kodp1_   Varchar2(6);
znap_    Varchar2(30);
ddd_     Varchar(3);
userid_  Number;

--- остатки отчетного года
CURSOR SALDOOG IS
   SELECT a.acc, a.nls, a.kv, b.fdat,
         gl.p_icurval(a.kv, b.ostf-b.dos+b.kos, Dat_)
   FROM saldoa b, accounts a
   WHERE a.acc=b.acc                            AND
         a.nbs in (select distinct r020 from kl_f3_29 where kf='B7') AND
         (a.acc,b.fdat) =
         (select c.acc,max(c.fdat)
          from saldoa c
          where a.acc=c.acc and c.fdat <= Dat_
          group by c.acc) ;

--- остатки отчетного года счетов технической переоценки
CURSOR SALDOOGP IS
   SELECT a.acc, a.nls, a.kv, b.fdat, b.ostf-b.dos+b.kos
   FROM saldob b, accounts a, tabval t
   WHERE a.acc=b.acc                            AND
         a.nbs in (select distinct r020 from kl_f3_29 where kf='B7') AND
         a.kv=t.kv                                                   AND
         a.kv <> 980                                                 AND
         (a.nls=t.s0000 or a.nls=t.s3800 or a.nls=t.s3801)           AND
         (a.acc,b.fdat) =
         (select c.acc,max(c.fdat)
          from saldob c
          where a.acc=c.acc and c.fdat <= Dat_
          group by c.acc) ;

--- Корректирующие проводки для счетов отсутствующих в конце месяца ---
CURSOR SALDOOGK IS
   SELECT s.acc, s.nls, s.kv, s.daos, s.nbs,
          NVL(SUM(DECODE(a.dk, 1, 1, -1)*a.s), 0)
   FROM  kor_prov a, accounts s
   WHERE s.nbs in (select distinct r020 from kl_f3_29 where kf='B7') AND
         a.fdat > Dat_                 AND
         a.fdat <= Dat2_               AND
         a.acc=s.acc                   AND
         a.vob=96                      AND
         s.daos > Dat_
  GROUP BY s.acc, s.nls, s.kv, s.daos, s.nbs ;

--- прошлый год
--- остатки конца прошлого года
CURSOR SALDOPG IS
   SELECT a.acc, a.nls, a.kv, b.fdat,
         gl.p_icurval(a.kv, b.ostf-b.dos+b.kos, Dat_)
   FROM saldoa b, accounts a
   WHERE a.acc=b.acc                            AND
         a.nbs in (select distinct r020 from kl_f3_29 where kf='B7') AND
         (a.acc,b.fdat) =
         (select c.acc,max(c.fdat)
          from saldoa c
          where a.acc=c.acc and c.fdat <= Dat3_
          group by c.acc) ;

--- остатки конца прошлого года счетов технической переоценки
CURSOR SALDOPGP IS
   SELECT a.acc, a.nls, a.kv, b.fdat, b.ostf-b.dos+b.kos
   FROM saldob b, accounts a, tabval t
   WHERE a.acc=b.acc                            AND
         a.nbs in (select distinct r020 from kl_f3_29 where kf='B7') AND
         a.kv=t.kv                                                   AND
         a.kv <> 980                                                 AND
         (a.nls=t.s0000 or a.nls=t.s3800 or a.nls=t.s3801)           AND
         (a.acc,b.fdat) =
         (select c.acc,max(c.fdat)
          from saldob c
          where a.acc=c.acc and c.fdat <= Dat3_
          group by c.acc) ;

--- Корректирующие проводки для счетов отсутствующих в конце месяца ---
--- конец прошлого года
CURSOR SALDOPGK IS
   SELECT s.acc, s.nls, s.kv, s.daos, s.nbs,
          NVL(SUM(DECODE(a.dk, 1, 1, -1)*a.s), 0)
   FROM  kor_prov a, accounts s
   WHERE s.nbs in (select distinct r020 from kl_f3_29 where kf='B7') AND
         a.fdat > Dat3_                AND
         a.fdat <= Dat4_               AND
         a.acc=s.acc                   AND
         a.vob=96                      AND
         s.daos > Dat3_
  GROUP BY s.acc, s.nls, s.kv, s.daos, s.nbs ;

CURSOR BaseL IS
   SELECT kodp, SUM(znap)
---substr(kodp,2,5), SUM(to_number(znap))
   FROM rnbu_trace
   WHERE userid=userid_
---   GROUP BY substr(kodp,2,5)
   GROUP BY kodp
   ORDER BY kodp;

BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
Dat1_:= TRUNC(Dat_ - TO_NUMBER(TO_CHAR(Dat_,'DD')));
Dat2_ := TRUNC(Dat_ + 28);

data_:=to_date('31' || '12' || to_char(to_number(to_char(Dat_,'YYYY'))-1),
               'DDMMYYYY');

SELECT max(Fdat) INTO Dat3_ FROM FDAT WHERE fdat<=data_;

Dat4_:=TRUNC(Dat3_ + 28);
--------------------- Корректирующие проводки ---------------------
---TRUNCATE TABLE kor_prov ;
DELETE FROM ref_kor ;
IF to_char(Dat_,'MM')='12' THEN
   INSERT INTO ref_kor (REF, VOB, VDAT)
   SELECT ref, vob, vdat
   FROM oper
   WHERE (vob=96 OR vob=99) AND tt NOT LIKE 'ZG%' AND not
         (((substr(nlsa,1,1)='6' or substr(nlsa,1,1)='7')
          and substr(nlsb,1,4)='5040') or (substr(nlsa,1,4)='5040' and
          (substr(nlsb,1,1)='6' or substr(nlsb,1,1)='7'))) ;
ELSE
   INSERT INTO ref_kor (REF, VOB, VDAT)
   SELECT ref, vob, vdat
   FROM oper
   WHERE vob=96 OR vob=99 ;
END IF ;

DELETE FROM kor_prov ;
INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
SELECT o.ref, o.dk, o.acc, o.s, o.fdat, p.vdat, o.sos, p.vob
FROM opldok o, ref_kor p     --- oper p
WHERE o.fdat>Dat1_     AND
      o.fdat<=Dat2_    AND
      o.ref=p.ref      AND
      o.sos=5 ;
-------------------------------------------------------------------
--- остатки отчетного года
OPEN SALDOOG;
LOOP
   FETCH SALDOOG INTO acc_, nls_, kv_, data_, sn_;
   EXIT WHEN SALDOOG%NOTFOUND;

   nbs_:=substr(nls_,1,4);

--- отбор корректирующих проводок отчетного месяца
   BEGIN
      SELECT d.acc,
         SUM(DECODE(d.dk, 0, GL.P_ICURVAL(kv_, d.s, Dat_), 0)),
         SUM(DECODE(d.dk, 1, GL.P_ICURVAL(kv_, d.s, Dat_), 0))
      INTO acc1_, Dosek_, Kosek_
      FROM  kor_prov d
      WHERE d.acc=acc_                   AND
            d.fdat > Dat_                AND
            d.fdat <= Dat2_              AND
            d.vob = 96
      GROUP BY d.acc ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      Dosek_ :=0 ;
      Kosek_ :=0 ;
   END ;

   sn_:=sn_-Dosek_+Kosek_;

   BEGIN
      SELECT NVL(SUM(p.s*decode(p.dk,0,-1,1,1,0)),0) INTO Dose_
      FROM oper o, opldok p
      WHERE o.ref  = p.ref  AND
            p.fdat = dat_   AND
            o.sos  = 5      AND
            p.acc  = acc_   AND
            o.tt  like  'ZG%' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      Dose_:=0;
   END;

   sn_:=sn_-Dose_;

   dk_:=IIF_N(sn_,0,'1','2','2');
   BEGIN
      SELECT NVL(ddd,'000'), r012, NVL(substr(txt,1,2),'00'), NVL(r050,'03')
      INTO ddd_, r012_, kod_11, r050_ FROM kl_f3_29
      WHERE kf='B7' and r020=nbs_ and r012=dk_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
         SELECT NVL(ddd,'000'), r012, NVL(substr(txt,1,2),'00'), NVL(r050,'03')
         INTO ddd_, r012_, kod_11, r050_ FROM kl_f3_29
         WHERE kf='B7' and r020=nbs_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         ddd_:='000';
         r012_ :='1' ;
         kod_11:='00';
         r050_:='03';
      END ;
   END ;

   IF nbs_='6300' THEN
      BEGIN
         SELECT NVL(r013,'1') INTO r013_ FROM specparam
         WHERE acc=acc_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         r013_:='1';
      END ;
      IF r013_ in ('1','2','3') THEN
         ddd_:='606';
      END IF;
   END IF;

   IF sn_ > 0 and r050_='11' THEN
      sn_:=0;
   END IF;
   IF sn_ < 0 and r050_='22' THEN
      sn_:=0;
   END IF;

   IF sn_ <> 0 THEN
      dk_:=IIF_N(sn_,0,'1','2','2');
      IF r012_='1' and sn_>0 THEN
         dk_:='1';
      END IF;
      IF r012_='2' and sn_<0 THEN
         dk_:='2';
      END IF;
      kodp_:= dk_ || RTRIM(ddd_) || '10' ;
      znap_:= TO_CHAR(sn_);
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
      IF kod_11='11' THEN
         kodp_:= dk_ || RTRIM(ddd_) || '11' ;
         znap_:= TO_CHAR(sn_);
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);
      END IF;
   END IF;
END LOOP;
CLOSE SALDOOG;
-----------------------------------------------------------------------------
--- остатки отчетного года счетов технической переоценки
OPEN SALDOOGP;
LOOP
   FETCH SALDOOGP INTO acc_, nls_, kv_, data_, sn_;
   EXIT WHEN SALDOOGP%NOTFOUND;

   nbs_:=substr(nls_,1,4);
   dk_:=IIF_N(sn_,0,'1','2','2');
   BEGIN
      SELECT NVL(ddd,'000'), r012, NVL(substr(txt,1,2),'00'), NVL(r050,'03')
      INTO ddd_, r012_, kod_11, r050_ FROM kl_f3_29
      WHERE kf='B7' and r020=nbs_ and r012=dk_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
         SELECT NVL(ddd,'000'), r012, NVL(substr(txt,1,2),'00'), NVL(r050,'03')
         INTO ddd_, r012_, kod_11, r050_ FROM kl_f3_29
         WHERE kf='B7' and r020=nbs_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         ddd_:='000';
         r012_ :='1' ;
         kod_11:='00';
         r050_:='03';
      END ;
   END ;

   IF nbs_='6300' THEN
      BEGIN
         SELECT NVL(r013,'1') INTO r013_ FROM specparam
         WHERE acc=acc_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         r013_:='1';
      END ;
      IF r013_ in ('1','2','3') THEN
         ddd_:='606';
      END IF;
   END IF;

   IF sn_ > 0 and r050_='11' THEN
      sn_:=0;
   END IF;
   IF sn_ < 0 and r050_='22' THEN
      sn_:=0;
   END IF;

   IF sn_ <> 0 THEN
      dk_:=IIF_N(sn_,0,'1','2','2');
      IF r012_='1' and sn_>0 THEN
         dk_:='1';
      END IF;
      IF r012_='2' and sn_<0 THEN
         dk_:='2';
      END IF;
      kodp_:= dk_ || RTRIM(ddd_) || '10' ;
      znap_:= TO_CHAR(sn_);
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
      IF kod_11='11' THEN
         kodp_:= dk_ || RTRIM(ddd_) || '11' ;
         znap_:= TO_CHAR(sn_);
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);
      END IF;
   END IF;
END LOOP;
CLOSE SALDOOGP;
-----------------------------------------------------------------------------
--- Остатки сформиров. по корр.проводкам для сч. отсутств. в конце месяца ---
OPEN SALDOOGK;
   LOOP
   FETCH SALDOOGK INTO acc_, nls_, kv_, data_, Nbs_, Kosek_ ;
   EXIT WHEN SALDOOGK%NOTFOUND;

   dk_:=IIF_N(Kosek_,0,'1','2','2');
   BEGIN
      SELECT NVL(ddd,'000'), r012, NVL(substr(txt,1,2),'00'), NVL(r050,'03')
      INTO ddd_, r012_, kod_11, r050_ FROM kl_f3_29
      WHERE kf='B7' and r020=nbs_ and r012=dk_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
         SELECT NVL(ddd,'000'), r012, NVL(substr(txt,1,2),'00'), NVL(r050,'03')
         INTO ddd_, r012_, kod_11, r050_ FROM kl_f3_29
         WHERE kf='B7' and r020=nbs_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         ddd_:='000';
         r012_ :='1' ;
         kod_11:='00';
         r050_:='03';
      END ;
   END ;

   IF nbs_='6300' THEN
      BEGIN
         SELECT NVL(r013,'1') INTO r013_ FROM specparam
         WHERE acc=acc_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         r013_:='1';
      END ;
      IF r013_ in ('1','2','3') THEN
         ddd_:='606';
      END IF;
   END IF;

   Kosek_:=gl.p_icurval(kv_, Kosek_, Dat_);

   IF Kosek_ > 0 and r050_='11' THEN
      Kosek_:=0;
   END IF;
   IF Kosek_ < 0 and r050_='22' THEN
      Kosek_:=0;
   END IF;

   IF Kosek_<>0 THEN
      dk_:=IIF_N(Kosek_,0,'1','2','2');
      IF r012_='1' and Kosek_>0 THEN
         dk_:='1';
      END IF;
      IF r012_='2' and Kosek_<0 THEN
         dk_:='2';
      END IF;
      kodp_:= dk_ || RTRIM(ddd_) || '10' ;
      znap_:= TO_CHAR(Kosek_);
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
      IF kod_11='11' THEN
         kodp_:= dk_ || RTRIM(ddd_) || '11' ;
         znap_:= TO_CHAR(sn_);
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);
      END IF;
   END IF;
END LOOP;
CLOSE SALDOOGK;
-----------------------------------------------------------------------------
---прошлый год
DELETE FROM kor_prov ;
INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
SELECT o.ref, o.dk, o.acc, o.s, o.fdat, p.vdat, o.sos, p.vob
FROM opldok o, ref_kor p     --- oper p
WHERE o.fdat>Dat3_     AND
      o.fdat<=Dat4_    AND
      o.ref=p.ref      AND
      o.sos=5 ;

--- остатки конца предыдущего года
OPEN SALDOPG;
LOOP
   FETCH SALDOPG INTO acc_, nls_, kv_, data_, sn_;
   EXIT WHEN SALDOPG%NOTFOUND;

   nbs_:=substr(nls_,1,4);

--- отбор корректирующих проводок отчетного месяца
   BEGIN
      SELECT d.acc,
         SUM(DECODE(d.dk, 0, GL.P_ICURVAL(kv_, d.s, Dat_), 0)),
         SUM(DECODE(d.dk, 1, GL.P_ICURVAL(kv_, d.s, Dat_), 0))
      INTO acc1_, Dosek_, Kosek_
      FROM  kor_prov d
      WHERE d.acc=acc_                   AND
            d.fdat > Dat3_                AND
            d.fdat <= Dat4_              AND
            d.vob = 96
      GROUP BY d.acc ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      Dosek_ :=0 ;
      Kosek_ :=0 ;
   END ;

   sn_:=sn_-Dosek_+Kosek_;

   BEGIN
      SELECT NVL(SUM(p.s*decode(p.dk,0,-1,1,1,0)),0) INTO Dose_
      FROM oper o, opldok p
      WHERE o.ref  = p.ref  AND
            p.fdat = dat3_  AND
            o.sos  = 5      AND
            p.acc  = acc_   AND
            o.tt  like  'ZG%' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      Dose_:=0;
   END;

   sn_:=sn_-Dose_;

   dk_:=IIF_N(sn_,0,'1','2','2');
   BEGIN
      SELECT NVL(ddd,'000'), r012, NVL(substr(txt,1,2),'00'), NVL(r050,'03')
      INTO ddd_, r012_, kod_11, r050_ FROM kl_f3_29
      WHERE kf='B7' and r020=nbs_ and r012=dk_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
         SELECT NVL(ddd,'000'), r012, NVL(substr(txt,1,2),'00'), NVL(r050,'03')
         INTO ddd_, r012_, kod_11, r050_ FROM kl_f3_29
         WHERE kf='B7' and r020=nbs_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         ddd_:='000';
         r012_ :='1' ;
         kod_11:='00';
         r050_:='03';
      END ;
   END ;

   IF nbs_='6300' THEN
      BEGIN
         SELECT NVL(r013,'1') INTO r013_ FROM specparam
         WHERE acc=acc_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         r013_:='1';
      END ;
      IF r013_ in ('1','2','3') THEN
         ddd_:='606';
      END IF;
   END IF;

   IF sn_ > 0 and r050_='11' THEN
      sn_:=0;
   END IF;
   IF sn_ < 0 and r050_='22' THEN
      sn_:=0;
   END IF;

   IF sn_ <> 0 THEN
      dk_:=IIF_N(sn_,0,'1','2','2');
      IF r012_='1' and sn_>0 THEN
         dk_:='1';
      END IF;
      IF r012_='2' and sn_<0 THEN
         dk_:='2';
      END IF;
      kodp_:= dk_ || RTRIM(ddd_) || '20' ;
      znap_:= TO_CHAR(sn_);
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
      IF kod_11='11' THEN
         kodp_:= dk_ || RTRIM(ddd_) || '21' ;
         znap_:= TO_CHAR(sn_);
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);
      END IF;
   END IF;
END LOOP;
CLOSE SALDOPG;
-----------------------------------------------------------------------------
--- остатки конца предыдущего года счетов технической переоценки
OPEN SALDOPGP;
LOOP
   FETCH SALDOPGP INTO acc_, nls_, kv_, data_, sn_;
   EXIT WHEN SALDOPGP%NOTFOUND;

   nbs_:=substr(nls_,1,4);
   dk_:=IIF_N(sn_,0,'1','2','2');
   BEGIN
      SELECT NVL(ddd,'000'), r012, NVL(substr(txt,1,2),'00'), NVL(r050,'03')
      INTO ddd_, r012_, kod_11, r050_ FROM kl_f3_29
      WHERE kf='B7' and r020=nbs_ and r012=dk_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
         SELECT NVL(ddd,'000'), r012, NVL(substr(txt,1,2),'00'), NVL(r050,'03')
         INTO ddd_, r012_, kod_11, r050_ FROM kl_f3_29
         WHERE kf='B7' and r020=nbs_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         ddd_:='000';
         r012_ :='1' ;
         kod_11:='00';
         r050_:='03';
      END ;
   END ;

   IF nbs_='6300' THEN
      BEGIN
         SELECT NVL(r013,'1') INTO r013_ FROM specparam
         WHERE acc=acc_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         r013_:='1';
      END ;
      IF r013_ in ('1','2','3') THEN
         ddd_:='606';
      END IF;
   END IF;

   IF sn_ > 0 and r050_='11' THEN
      sn_:=0;
   END IF;
   IF sn_ < 0 and r050_='22' THEN
      sn_:=0;
   END IF;

   IF sn_ <> 0 THEN
      dk_:=IIF_N(sn_,0,'1','2','2');
      IF r012_='1' and sn_>0 THEN
         dk_:='1';
      END IF;
      IF r012_='2' and sn_<0 THEN
         dk_:='2';
      END IF;
      kodp_:= dk_ || RTRIM(ddd_) || '20' ;
      znap_:= TO_CHAR(sn_);
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
      IF kod_11='11' THEN
         kodp_:= dk_ || RTRIM(ddd_) || '21' ;
         znap_:= TO_CHAR(sn_);
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);
      END IF;
   END IF;
END LOOP;
CLOSE SALDOPGP;
-----------------------------------------------------------------------------
--- Остатки сформиров. по корр.проводкам для сч. отсутств. в конце месяца ---
--- конца предыдущего года
OPEN SALDOPGK;
   LOOP
   FETCH SALDOPGK INTO acc_, nls_, kv_, data_, Nbs_, Kosek_ ;
   EXIT WHEN SALDOPGK%NOTFOUND;

   dk_:=IIF_N(Kosek_,0,'1','2','2');
   BEGIN
      SELECT NVL(ddd,'000'), r012, NVL(substr(txt,1,2),'00'), NVL(r050,'03')
      INTO ddd_, r012_, kod_11, r050_ FROM kl_f3_29
      WHERE kf='B7' and r020=nbs_ and r012=dk_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
         SELECT NVL(ddd,'000'), r012, NVL(substr(txt,1,2),'00'), NVL(r050,'03')
         INTO ddd_, r012_, kod_11, r050_ FROM kl_f3_29
         WHERE kf='B7' and r020=nbs_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         ddd_:='000';
         r012_ :='1' ;
         kod_11:='00';
         r050_:='03';
      END ;
   END ;

   IF nbs_='6300' THEN
      BEGIN
         SELECT NVL(r013,'1') INTO r013_ FROM specparam
         WHERE acc=acc_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         r013_:='1';
      END ;
      IF r013_ in ('1','2','3') THEN
         ddd_:='606';
      END IF;
   END IF;

   Kosek_:=gl.p_icurval(kv_, Kosek_, Dat_);

   IF Kosek_ > 0 and r050_='11' THEN
      Kosek_:=0;
   END IF;
   IF Kosek_ < 0 and r050_='22' THEN
      Kosek_:=0;
   END IF;

   IF Kosek_<>0 THEN
      dk_:=IIF_N(Kosek_,0,'1','2','2');
      IF r012_='1' and Kosek_>0 THEN
         dk_:='1';
      END IF;
      IF r012_='2' and Kosek_<0 THEN
         dk_:='2';
      END IF;
      kodp_:= dk_ || RTRIM(ddd_) || '20' ;
      znap_:= TO_CHAR(Kosek_);
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
      IF kod_11='11' THEN
         kodp_:= dk_ || RTRIM(ddd_) || '21' ;
         znap_:= TO_CHAR(sn_);
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);
      END IF;
   END IF;
END LOOP;
CLOSE SALDOPGK;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf='B7' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   IF substr(kodp_,1,1)='1' THEN
      znap_:=0-znap_;
   END IF;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('B7', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
----------------------------------------
END p_fB7;
 
/
show err;

PROMPT *** Create  grants  P_FB7 ***
grant EXECUTE                                                                on P_FB7           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FB7           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FB7.sql =========*** End *** ===
PROMPT ===================================================================================== 
