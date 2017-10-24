

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F82.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F82 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F82 (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла #82 для КБ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 19.01.2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
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
kod_11_  Varchar2(2);
dd_      Varchar2(2);
Dat1_    Date;
Dat2_    Date;
Dat3_    Date;
Dat4_    Date;
data_    Date;
Datk_    Date;
kv_      SMALLINT;
sn_      DECIMAL(24);
se_      DECIMAL(24);
s6_7t    DECIMAL(24);
s6_7tk   DECIMAL(24);
s6_7p    DECIMAL(24);
s6_7pk   DECIMAL(24);
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
         a.nbs in (select distinct r020 from kl_f3_29 where kf='82') AND
         (a.acc,b.fdat) =
         (select c.acc,max(c.fdat)
          from saldoa c
          where a.acc=c.acc and c.fdat <= Dat_
          group by c.acc) ;

--- Корректирующие проводки для счетов отсутствующих в конце года ---
CURSOR SALDOOGK IS
   SELECT s.acc, s.nls, s.kv, s.daos, s.nbs,
          NVL(SUM(DECODE(a.dk, 1, 1, -1)*a.s), 0)
   FROM  kor_prov a, accounts s
   WHERE s.nbs in (select distinct r020 from kl_f3_29 where kf='82') AND
         a.fdat > Dat_                 AND
         a.fdat <= Dat2_               AND
         a.acc=s.acc                   AND
         a.vob=96                      AND
         s.daos > Dat_
  GROUP BY s.acc, s.nls, s.kv, s.daos, s.nbs ;

--- остатки отчетного квартала предыдущего года
CURSOR SALDOPG IS
   SELECT a.acc, a.nls, a.kv, b.fdat,
         gl.p_icurval(a.kv, b.ostf-b.dos+b.kos, Dat3_)
   FROM saldoa b, accounts a
   WHERE a.acc=b.acc                            AND
         a.nbs in (select distinct r020 from kl_f3_29 where kf='82') AND
         (a.acc,b.fdat) =
         (select c.acc,max(c.fdat)
          from saldoa c
          where a.acc=c.acc and c.fdat <= Dat3_
          group by c.acc) ;

--- Корректирующие проводки для счетов отсутствующих в конце месяца ---
--- отчетного квартала предыдущего года
CURSOR SALDOPGK IS
   SELECT s.acc, s.nls, s.kv, s.daos, s.nbs,
          NVL(SUM(DECODE(a.dk, 1, 1, -1)*a.s), 0)
   FROM  kor_prov a, accounts s
   WHERE s.nbs in (select distinct r020 from kl_f3_29 where kf='82') AND
         a.fdat > Dat3_                AND
         a.fdat <= Dat4_               AND
         a.acc=s.acc                   AND
         a.vob=96                      AND
         s.daos > Dat3_
  GROUP BY s.acc, s.nls, s.kv, s.daos, s.nbs ;

--- остатки бал. счета 5040,5041 отчетного года
CURSOR SALDO5040 IS
   SELECT a.acc, a.nls, a.kv, b.fdat,
          b.ostf-b.dos+b.kos
   FROM saldoa b, accounts a
   WHERE a.acc=b.acc                            AND
         (a.nbs='5040' or a.nbs='5041')         AND
         (a.acc,b.fdat) =
         (select c.acc,max(c.fdat)
          from saldoa c
          where a.acc=c.acc and c.fdat <= Dat2_
          group by c.acc) ;

--- остатки бал. счета 5040,5041 предыдущего года
CURSOR SALDO5040P IS
   SELECT a.acc, a.nls, a.kv, b.fdat,
          b.ostf-b.dos+b.kos
   FROM saldoa b, accounts a
   WHERE a.acc=b.acc                            AND
         (a.nbs='5040' or a.nbs='5041')         AND
         (a.acc,b.fdat) =
         (select c.acc,max(c.fdat)
          from saldoa c
          where a.acc=c.acc and c.fdat <= Dat4_
          group by c.acc) ;

--- остатки счетов технической переоценки отчетного года
CURSOR SALDO3500 IS
   SELECT a.acc, a.nls, a.kv, b.fdat,
          b.ostf-b.dos+b.kos
   FROM saldob b, accounts a, tabval t
   WHERE a.acc=b.acc                            AND
         a.kv<>980                              AND
         a.kv=t.kv                              AND
         (a.nls=t.s0000 or a.nls=t.s3800 or a.nls=t.s3801)  AND
         a.nbs in (select distinct r020 from kl_f3_29 where kf='82') AND
         (a.acc,b.fdat) =
         (select c.acc,max(c.fdat)
          from saldob c
          where a.acc=c.acc and c.fdat <= Dat_
          group by c.acc) ;

--- остатки счетов технической переоценки предыдущего года
CURSOR SALDO3500P IS
   SELECT a.acc, a.nls, a.kv, b.fdat,
          b.ostf-b.dos+b.kos
   FROM saldob b, accounts a, tabval t
   WHERE a.acc=b.acc                            AND
         a.kv<>980                              AND
         a.kv=t.kv                              AND
         (a.nls=t.s0000 or a.nls=t.s3800 or a.nls=t.s3801)  AND
         a.nbs in (select distinct r020 from kl_f3_29 where kf='82') AND
         (a.acc,b.fdat) =
         (select c.acc,max(c.fdat)
          from saldob c
          where a.acc=c.acc and c.fdat <= Dat3_
          group by c.acc) ;

CURSOR BaseL IS
   SELECT kodp, SUM(znap)
   FROM rnbu_trace
   WHERE userid=userid_
   GROUP BY kodp
   ORDER BY kodp;

BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
Dat1_:= TRUNC(Dat_ - TO_NUMBER(TO_CHAR(Dat_,'DD')));
Dat2_:= TRUNC(Dat_ + 28);
Datk_:= TRUNC(Dat_ + 150);

IF to_char(Dat_,'MM')='03' OR to_char(Dat_,'MM')='12' THEN
   dd_:='31';
ELSE
   dd_:='30';
END IF;
data_:=to_date('31' || '12' ||
               to_char(to_number(to_char(Dat_,'YYYY'))-1),'DDMMYYYY');

---SELECT max(Fdat) INTO Dat3_ FROM FDAT WHERE fdat<=data_;

---data_:=TRUNC(Dat3_ - 1);

SELECT max(Fdat) INTO Dat3_ FROM FDAT WHERE fdat<=data_;

Dat4_:=TRUNC(Dat3_ + 28);
--------------------- Корректирующие проводки ---------------------
---TRUNCATE TABLE kor_prov ;
DELETE FROM ref_kor ;
IF to_char(Dat_,'MM')='12' THEN
   INSERT INTO ref_kor (REF, VOB, VDAT)
   SELECT ref, vob, vdat
   FROM oper
   WHERE (vob=96 OR vob=99) AND tt NOT LIKE 'ZG%' AND
          not (((substr(nlsa,1,1)='6' or substr(nlsa,1,1)='7')
          and (substr(nlsb,1,4)='5040' or substr(nlsb,1,4)='5041')) or
          ((substr(nlsa,1,4)='5040' or substr(nlsa,1,4)='5041') and
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
WHERE o.fdat>Dat_      AND
      o.fdat<=Datk_    AND
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

--- отбор годовых корректирующих проводок
   BEGIN
      SELECT d.acc,
         SUM(DECODE(d.dk, 0, GL.P_ICURVAL(kv_, d.s, Dat_), 0)),
         SUM(DECODE(d.dk, 1, GL.P_ICURVAL(kv_, d.s, Dat_), 0))
      INTO acc1_, Dosek_, Kosek_
      FROM  kor_prov d
      WHERE d.acc=acc_                   AND
            d.fdat > Dat_                AND
            d.fdat <= Datk_              AND
            d.vob = 99
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
   IF substr(nbs_,1,1)='6' OR substr(nbs_,1,1)='7' THEN
      BEGIN
         SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
         WHERE kf='82' and r020=nbs_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         ddd_:='000';
      END ;

      IF nbs_='6300' THEN  --OR nbs_='7900' OR nbs_='7399'
         BEGIN
            SELECT NVL(r013,'0') INTO r013_ FROM specparam
            WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            r013_:='0';
         END ;
         IF nbs_='6300' and r013_ in ('0','1','2','3') THEN
            ddd_:='606';
         END IF;
--         IF nbs_='7900' and r013_ in ('3','4') THEN
--            ddd_:='710';
--         END IF;
--         IF nbs_='7399' and r013_='Z' THEN
--            ddd_:='713';
--         END IF;
      END IF;
   ELSE
      BEGIN
         SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
         WHERE kf='82' and r020=nbs_ and r012=dk_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         BEGIN
            SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
            WHERE kf='82' and r020=nbs_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            ddd_:='000';
         END ;
      END ;
   END IF;

   IF sn_ <> 0 and nbs_<>'5040' and nbs_<>'5041' THEN
      dk_:=IIF_N(sn_,0,'1','2','2');
      kodp_:= dk_ || RTRIM(ddd_) || '10' ;
      znap_:= TO_CHAR(ABS(sn_));
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
   END IF;
END LOOP;
CLOSE SALDOOG;
-----------------------------------------------------------------------------
--- Остатки сформиров. по корр.проводкам для сч. отсутств. в конце месяца ---
OPEN SALDOOGK;
   LOOP
   FETCH SALDOOGK INTO acc_, nls_, kv_, data_, Nbs_, Kosek_ ;
   EXIT WHEN SALDOOGK%NOTFOUND;

   dk_:=IIF_N(Kosek_,0,'1','2','2');

   IF substr(nbs_,1,1)='6' OR substr(nbs_,1,1)='7' THEN
      BEGIN
         SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
         WHERE kf='82' and r020=nbs_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         ddd_:='000';
      END ;

      IF nbs_='6300' THEN  --OR nbs_='7900' OR nbs_='7399'
         BEGIN
            SELECT NVL(r013,'0') INTO r013_ FROM specparam
            WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            r013_:='0';
         END ;
         IF nbs_='6300' and r013_ in ('0','1','2','3') THEN
            ddd_:='606';
         END IF;
--         IF nbs_='7900' and r013_ in ('3','4') THEN
--            ddd_:='710';
--         END IF;
--         IF nbs_='7399' and r013_='Z' THEN
--            ddd_:='713';
--         END IF;
      END IF;
   ELSE
      BEGIN
         SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
         WHERE kf='82' and r020=nbs_ and r012=dk_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         BEGIN
            SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
            WHERE kf='82' and r020=nbs_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            ddd_:='000';
         END ;
      END ;
   END IF;

---   IF nbs_='5040' THEN
---      BEGIN
---         SELECT NVL(r013,'9') INTO r013_ FROM specparam
---         WHERE acc=acc_;
---      EXCEPTION WHEN NO_DATA_FOUND THEN
---         r013_:='9';
---      END ;
---      IF r013_='1' THEN
---         kod_11_:='11';
---      END IF;
---   END IF;

   Kosek_:=gl.p_icurval(kv_, Kosek_, Dat_);

   IF Kosek_<>0 and nbs_<>'5040' and nbs_<>'5041' THEN
      dk_:=IIF_N(Kosek_,0,'1','2','2');
      kodp_:= dk_ || RTRIM(ddd_) || '10' ;
      znap_:= TO_CHAR(ABS(Kosek_));
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
---      IF kod_11_='11' THEN
---         kodp_:= dk_ || RTRIM(ddd_) || '11' ;
---         znap_:= TO_CHAR(Kosek_);
---         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
---                                (nls_, kv_, data_, kodp_, znap_);
---      END IF;
   END IF;
END LOOP;
CLOSE SALDOOGK;
--------------------------------------------------------------------------
--- остатки бал. счета 5040, 5041 отчетного года
OPEN SALDO5040;
LOOP
   FETCH SALDO5040 INTO acc_, nls_, kv_, data_, sn_;
   EXIT WHEN SALDO5040%NOTFOUND;

   nbs_:=substr(nls_,1,4);

   dk_:=IIF_N(sn_,0,'1','2','2');
   BEGIN
      SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
      WHERE kf='82' and r020=nbs_ and r012=dk_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
         SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
         WHERE kf='82' and r020=nbs_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         ddd_:='000';
      END ;
   END ;

   IF sn_ <> 0 THEN
      dk_:=IIF_N(sn_,0,'1','2','2');
      kodp_:= dk_ || RTRIM(ddd_) || '10' ;
      znap_:= TO_CHAR(ABS(sn_));
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
   END IF;
END LOOP;
CLOSE SALDO5040;

--- остатки бал. счета 5040, 5041 предыдущего года
OPEN SALDO5040P;
LOOP
   FETCH SALDO5040P INTO acc_, nls_, kv_, data_, sn_;
   EXIT WHEN SALDO5040P%NOTFOUND;

   nbs_:=substr(nls_,1,4);

   dk_:=IIF_N(sn_,0,'1','2','2');
   BEGIN
      SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
      WHERE kf='82' and r020=nbs_ and r012=dk_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
         SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
         WHERE kf='82' and r020=nbs_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         ddd_:='000';
      END ;
   END ;

   IF sn_ <> 0 THEN
      dk_:=IIF_N(sn_,0,'1','2','2');
      kodp_:= dk_ || RTRIM(ddd_) || '20' ;
      znap_:= TO_CHAR(ABS(sn_));
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
   END IF;
END LOOP;
CLOSE SALDO5040P;
-----------------------------------------------------------------------------
--- остатки счетов технической переоценки отчетного года
OPEN SALDO3500;
LOOP
   FETCH SALDO3500 INTO acc_, nls_, kv_, data_, sn_;
   EXIT WHEN SALDO3500%NOTFOUND;

   nbs_:=substr(nls_,1,4);
   kod_11_:='00';

   dk_:=IIF_N(sn_,0,'1','2','2');
   BEGIN
      SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
      WHERE kf='82' and r020=nbs_ and r012=dk_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
         SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
         WHERE kf='82' and r020=nbs_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         ddd_:='000';
      END ;
   END ;

   IF sn_ <> 0  THEN
      dk_:=IIF_N(sn_,0,'1','2','2');
      kodp_:= dk_ || RTRIM(ddd_) || '10' ;
      znap_:= TO_CHAR(ABS(sn_));
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
   END IF;
END LOOP;
CLOSE SALDO3500;
-----------------------------------------------------------------------------
--- предыдущий год

DELETE FROM kor_prov ;
INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
SELECT o.ref, o.dk, o.acc, o.s, o.fdat, p.vdat, o.sos, p.vob
FROM opldok o, ref_kor p     --- oper p
WHERE o.fdat>Dat3_     AND
      o.fdat<=Dat4_    AND
      o.ref=p.ref      AND
      o.sos=5 ;

--- остатки отчетного квартала предыдущего года
OPEN SALDOPG;
LOOP
   FETCH SALDOPG INTO acc_, nls_, kv_, data_, sn_;
   EXIT WHEN SALDOPG%NOTFOUND;

   nbs_:=substr(nls_,1,4);
   kod_11_:='00';

--- отбор корректирующих проводок отчетного месяца
   BEGIN
      SELECT d.acc,
         SUM(DECODE(d.dk, 0, GL.P_ICURVAL(kv_, d.s, Dat3_), 0)),
         SUM(DECODE(d.dk, 1, GL.P_ICURVAL(kv_, d.s, Dat3_), 0))
      INTO acc1_, Dosek_, Kosek_
      FROM  kor_prov d
      WHERE d.acc=acc_                   AND
            d.fdat > Dat3_               AND
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
   IF substr(nbs_,1,1)='6' OR substr(nbs_,1,1)='7' THEN
      BEGIN
         SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
         WHERE kf='82' and r020=nbs_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         ddd_:='000';
      END ;

      IF nbs_='6300' THEN  --OR nbs_='7900' OR nbs_='7399'
         BEGIN
            SELECT NVL(r013,'0') INTO r013_ FROM specparam
            WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            r013_:='0';
         END ;
         IF nbs_='6300' and r013_ in ('0','1','2','3') THEN
            ddd_:='606';
         END IF;
--         IF nbs_='7900' and r013_ in ('3','4') THEN
--            ddd_:='710';
--         END IF;
--         IF nbs_='7399' and r013_='Z' THEN
--            ddd_:='713';
--         END IF;
      END IF;
   ELSE
      BEGIN
         SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
         WHERE kf='82' and r020=nbs_ and r012=dk_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         BEGIN
            SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
            WHERE kf='82' and r020=nbs_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            ddd_:='000';
         END ;
      END ;
   END IF;

---   IF nbs_='5040' THEN
---      BEGIN
---         SELECT NVL(r013,'9') INTO r013_ FROM specparam
---         WHERE acc=acc_;
---      EXCEPTION WHEN NO_DATA_FOUND THEN
---         r013_:='9';
---      END ;
---      IF r013_='1' THEN
---         kod_11_:='11';
---      END IF;
---   END IF;

   IF sn_ <> 0 and nbs_<>'5040' and nbs_<>'5041' THEN
      dk_:=IIF_N(sn_,0,'1','2','2');
      kodp_:= dk_ || RTRIM(ddd_) || '20' ;
      znap_:= TO_CHAR(ABS(sn_));
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
---     IF kod_11_='11' THEN
---         kodp_:= dk_ || RTRIM(ddd_) || '21' ;
---         znap_:= TO_CHAR(ABS(sn_));
---         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
---                                (nls_, kv_, data_, kodp_, znap_);
---      END IF;
   END IF;
END LOOP;
CLOSE SALDOPG;
-----------------------------------------------------------------------------
--- Остатки сформиров. по корр.проводкам для сч. отсутств. в конце месяца ---
--- отчетного квартала предыдущего года
OPEN SALDOPGK;
   LOOP
   FETCH SALDOPGK INTO acc_, nls_, kv_, data_, Nbs_, Kosek_ ;
   EXIT WHEN SALDOPGK%NOTFOUND;

   dk_:=IIF_N(Kosek_,0,'1','2','2');

   IF substr(nbs_,1,1)='6' OR substr(nbs_,1,1)='7' THEN
      BEGIN
         SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
         WHERE kf='82' and r020=nbs_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         ddd_:='000';
      END ;

      IF nbs_='6300' THEN  --OR nbs_='7900' OR nbs_='7399'
         BEGIN
            SELECT NVL(r013,'0') INTO r013_ FROM specparam
            WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            r013_:='0';
         END ;
         IF nbs_='6300' and r013_ in ('0','1','2','3') THEN
            ddd_:='606';
         END IF;
--         IF nbs_='7900' and r013_ in ('3','4') THEN
--            ddd_:='710';
--         END IF;
--         IF nbs_='7399' and r013_='Z' THEN
--            ddd_:='713';
--         END IF;
      END IF;
   ELSE
      BEGIN
         SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
         WHERE kf='82' and r020=nbs_ and r012=dk_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         BEGIN
            SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
            WHERE kf='82' and r020=nbs_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            ddd_:='000';
         END ;
      END ;
   END IF;

---   IF nbs_='5040' THEN
---      BEGIN
---         SELECT NVL(r013,'9') INTO r013_ FROM specparam
---         WHERE acc=acc_;
---      EXCEPTION WHEN NO_DATA_FOUND THEN
---         r013_:='9';
---      END ;
---      IF r013_='1' THEN
---         kod_11_:='11';
---      END IF;
---   END IF;

   Kosek_:=gl.p_icurval(kv_, Kosek_, Dat3_);

   IF Kosek_<>0 and nbs_<>'5040' and nbs_<>'5041' THEN
      dk_:=IIF_N(Kosek_,0,'1','2','2');
      kodp_:= dk_ || RTRIM(ddd_) || '20' ;
      znap_:= TO_CHAR(ABS(Kosek_));
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
---      IF kod_11_='11' THEN
---         kodp_:= dk_ || RTRIM(ddd_) || '21' ;
---         znap_:= TO_CHAR(ABS(Kosek_));
---         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
---                                (nls_, kv_, data_, kodp_, znap_);
---      END IF;
   END IF;
END LOOP;
CLOSE SALDOPGK;
----------------------------------------------------------------------------
--- остатки счетов технической переоценки предыдущего года
OPEN SALDO3500P;
LOOP
   FETCH SALDO3500P INTO acc_, nls_, kv_, data_, sn_;
   EXIT WHEN SALDO3500P%NOTFOUND;

   nbs_:=substr(nls_,1,4);
   kod_11_:='00';

   dk_:=IIF_N(sn_,0,'1','2','2');
   BEGIN
      SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
      WHERE kf='82' and r020=nbs_ and r012=dk_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
         SELECT NVL(ddd,'000') INTO ddd_ FROM kl_f3_29
         WHERE kf='82' and r020=nbs_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         ddd_:='000';
      END ;
   END ;

   IF sn_ <> 0  THEN
      dk_:=IIF_N(sn_,0,'1','2','2');
      kodp_:= dk_ || RTRIM(ddd_) || '20' ;
      znap_:= TO_CHAR(ABS(sn_));
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
   END IF;
END LOOP;
CLOSE SALDO3500P;
----------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_nbu where kodf='82' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('82', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
----------------------------------------
INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('82', Dat_, '252119', '0');
INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('82', Dat_, '252129', '0');
INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('82', Dat_, '252219', '0');
INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('82', Dat_, '252229', '0');
----------------------------------------
END p_f82;
 
/
show err;

PROMPT *** Create  grants  P_F82 ***
grant EXECUTE                                                                on P_F82           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F82           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F82.sql =========*** End *** ===
PROMPT ===================================================================================== 
