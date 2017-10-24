

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F33SBR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F33SBR ***

  CREATE OR REPLACE PROCEDURE BARS.P_F33SBR (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   :	otcn.sql
% DESCRIPTION :	ќтчетность —берЅанка: формирование файлов
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

acc_     Number;
acc1_    Number;
acc2_    Number;
nbs_     Varchar2(4);
kv_      SMALLINT;
nls_     Varchar2(15);
s0000_   Varchar2(15);
s0009_   Varchar2(15);
data_    Date;
dat1_    Date;
dat2_    Date;
Dosn_    DECIMAL(24);
Dose_    DECIMAL(24);
Kosn_    DECIMAL(24);
Kose_    DECIMAL(24);
Dosnk_   DECIMAL(24);
Dosek_   DECIMAL(24);
Kosnk_   DECIMAL(24);
Kosek_   DECIMAL(24);
zz_      Varchar2(2);
mfo_     Varchar2(12);
sn_      DECIMAL(24);
se_      DECIMAL(24);
dk_      Char(1);
kodp_    Varchar2(13);
znap_    Varchar2(30);
f33_     SMALLINT;
f33k_    SMALLINT;
userid_  Number;

---CURSOR SCHETA IS
---    SELECT s.acc
---    FROM accounts s, sb_r020 k
---    WHERE s.nbs=k.r020    AND
---          k.f_33='1' ;

--ќстатки номиналы (грн.+валюта)
CURSOR SALDO IS
   SELECT a.acc, a.nls, a.kv, a.nbs, a.fdat, '00', NVL(c.mfo,'000000'),
          a.ostf-a.dos+a.kos
   FROM (SELECT s.acc, s.nls, s.kv, s.nbs, aa.fdat, aa.ostf,
         aa.dos, aa.kos
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc     AND
              (s.acc,aa.fdat) =
               (select c.acc,max(c.fdat)
                from saldoa c
                where s.acc=c.acc and c.fdat <= Dat_
                group by c.acc)) a,
         custbank c, cust_acc ca
   WHERE a.acc=ca.acc              AND
         ca.rnk=c.rnk              AND
         ABS(a.ostf-a.dos+a.kos) >= 0 ;

--ќстатки сч. тех. переоценки и валютные эквиваленты
CURSOR SALDOQ IS
   SELECT a.acc, a.nls, a.kv, a.nbs, a.fdat, '00', NVL(c.mfo,'000000'),
          a.ostf-a.dos+a.kos
   FROM (SELECT s.acc, s.nls, s.kv, s.nbs, aa.fdat, aa.ostf,
         aa.dos, aa.kos
         FROM saldob aa, accounts s
         WHERE aa.acc=s.acc     AND
              (s.acc,aa.fdat) =
               (select c.acc,max(c.fdat)
                from saldob c
                where s.acc=c.acc and c.fdat <= Dat_
                group by c.acc)) a,
         custbank c, cust_acc ca
   WHERE a.acc=ca.acc              AND
         ca.rnk=c.rnk              AND
         ABS(a.ostf-a.dos+a.kos) >= 0 ;
-----------------------------------------------------------------------
---  орректирующие проводки дл€ счетов отсутствующих в конце мес€ца ---
CURSOR SaldoAOstfk IS
   SELECT s.acc, s.nls, s.kv, s.daos, s.nbs, '00', NVL(c.mfo,'000000'),
          SUM(DECODE(a.dk, 0, a.s, 0)),
---          SUM(DECODE(a.dk, 0, GL.P_ICURVAL(s.kv, a.s, Dat_), 0)),
          SUM(DECODE(a.dk, 1, a.s, 0))
---          SUM(DECODE(a.dk, 1, GL.P_ICURVAL(s.kv, a.s, Dat_), 0))
   FROM  kor_prov a, accounts s, cust_acc ca, custbank c
   WHERE a.fdat > Dat_                 AND
         a.fdat <= Dat2_               AND
         a.acc=s.acc                   AND
         s.daos > Dat_                 AND
         a.acc=ca.acc                  AND
         c.rnk=ca.rnk                  AND
         a.vob=96
   GROUP BY s.acc, s.nls, s.kv, s.daos, s.nbs, '00', NVL(c.mfo,'000000');
-----------------------------------------------------------------------
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
---------------------  орректирующие проводки ---------------------
---TRUNCATE TABLE kor_prov ;
DELETE FROM ref_kor ;
IF to_char(Dat_,'MM')='12' THEN

   INSERT INTO ref_kor (REF, VOB, VDAT)
   SELECT ref, vob, vdat
   FROM oper
   WHERE vob=96 and not (((substr(nlsa,1,1)='6' or substr(nlsa,1,1)='7')
       and substr(nlsb,1,4)='5040') or (substr(nlsa,1,4)='5040' and
       (substr(nlsb,1,1)='6' or substr(nlsb,1,1)='7'))) ; --- or
---       (substr(nlsa,1,4)='3902' and nlsb='5040902') or
---       (nlsa='5040902' and substr(nlsb,1,4)='3903')) ;
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
---where o.ref=p.ref and p.vob>95 and o.sos=5;
---COMMIT;
-------------------------------------------------------------------
SELECT count(*) into f33k_
FROM tmp_irep
WHERE kodf='33' and datf=Dat_ ;

OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_, nls_, kv_, nbs_, data_, zz_, mfo_, sn_ ;
   EXIT WHEN SALDO%NOTFOUND;
   SELECT count(*) INTO f33_ FROM sb_r020
   WHERE r020=nbs_ and f_33='1' ;

   IF f33_ > 0 and kv_=980 THEN
--- отбор корректирующих проводок отчетного мес€ца
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

---занесение кодов спецпараметров по новым счетам
      IF f33k_=0 THEN
---       OPEN SCHETA;
---       LOOP
---       FETCH Scheta INTO acc1_ ;
---       EXIT WHEN Scheta%NOTFOUND;
         BEGIN
            SELECT acc, NVL(ob22,'00') INTO acc2_, zz_
            FROM Specparam_int
            WHERE acc=acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            acc2_:=0 ;
            zz_:='00';
         END ;

         IF acc2_=0 THEN
            insert into specparam_int (acc,ob22) VALUES (acc_,'00') ;
         END IF;
---       END LOOP;
---       CLOSE Scheta;
      END IF ;
----------------------------------------------------------------------------
      BEGIN
         SELECT NVL(ob22,'00') INTO zz_
         FROM specparam_int
         WHERE acc=acc_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_ := '00' ;
      END ;

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

      sn_:=sn_-Dosnk_+Kosnk_ ;
      sn_:=sn_-Dose_;

      dk_:=IIF_N(sn_,0,'1','2','2');
      kodp_:= dk_ || nbs_ || zz_ || mfo_ ;
      znap_:= TO_CHAR(ABS(sn_)) ;

      IF sn_<>0 THEN
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_,znap_) ;
      END IF ;
   END IF;
END LOOP;
CLOSE SALDO;
---------------------------------------------------------------------
OPEN SALDOQ;
LOOP
   FETCH SALDOQ INTO acc_, nls_, kv_, nbs_, data_, zz_, mfo_, sn_ ;
   EXIT WHEN SALDOQ%NOTFOUND;
   SELECT count(*) INTO f33_ FROM sb_r020
   WHERE r020=nbs_ and f_33='1' ;
   s0000_:= '0' ;
   s0009_:= '0' ;

   IF f33_ > 0 THEN
--- отбор корректирующих проводок отчетного мес€ца
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

---занесение кодов спецпараметров по новым счетам
      IF f33k_=0 THEN
---       OPEN SCHETA;
---      LOOP
---       FETCH Scheta INTO acc1_ ;
---       EXIT WHEN Scheta%NOTFOUND;
         BEGIN
            SELECT acc, NVL(ob22,'00') INTO acc2_, zz_
            FROM Specparam_int
            WHERE acc=acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            acc2_:=0 ;
            zz_:='00';
         END ;

         IF acc2_=0 THEN
            insert into specparam_int (acc,ob22) VALUES (acc_,'00') ;
         END IF;
---       END LOOP;
---       CLOSE Scheta;
      END IF ;

      BEGIN
         SELECT NVL(ob22,'00') INTO zz_
         FROM specparam_int
         WHERE acc=acc_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_ := '00' ;
      END ;

      BEGIN
         SELECT s0000, s0009 INTO s0000_, s0009_
         FROM tabval WHERE kv=kv_ and (s0000=nls_ or s0009=nls_) ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         s0000_ := '0' ;
         s0009_ := '0' ;
      END ;

      sn_:=sn_-Dosnk_+Kosnk_ ;
      dk_:=IIF_N(sn_,0,'1','2','2');
      kodp_:= dk_ || nbs_ || zz_ || mfo_ ;
      znap_:= TO_CHAR(ABS(sn_)) ;

      IF sn_<>0 THEN
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_,znap_);
      END IF ;
   END IF;
END LOOP;
CLOSE SALDOQ;
-----------------------------------------------------------------------------
--- ќстатки сформиров. по корр.проводкам дл€ сч. отсутств. в конце мес€ца ---
OPEN SaldoAOstfk;
   LOOP
   FETCH SaldoAOstfk INTO acc_, nls_, kv_, data_, Nbs_, zz_, mfo_, Dosn_, Kosn_ ;
   EXIT WHEN SaldoAOstfk%NOTFOUND;

   SELECT count(*) INTO f33_ FROM sb_r020 WHERE r020=nbs_ and f_33='1' ;

   IF f33_ > 0 THEN
---занесение кодов спецпараметров по новым счетам
      IF f33k_=0 THEN
---       OPEN SCHETA;
---       LOOP
---       FETCH Scheta INTO acc1_ ;
---       EXIT WHEN Scheta%NOTFOUND;
         BEGIN
            SELECT acc, NVL(ob22,'00') INTO acc2_, zz_
            FROM Specparam_int
            WHERE acc=acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            acc2_:=0 ;
            zz_:='00';
         END ;

         IF acc2_=0 THEN
            insert into specparam_int (acc,ob22) VALUES (acc_,'00') ;
         END IF;
---       END LOOP;
---       CLOSE Scheta;
      END IF ;

      BEGIN
         SELECT NVL(ob22,'00') INTO zz_
         FROM specparam_int
         WHERE acc=acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;

      sn_:=Kosn_-Dosn_ ;
      IF kv_ <> 980 THEN
         se_ := GL.P_ICURVAL(kv_, sn_, Dat_) ;
      ELSE
         se_ := sn_ ;
      END IF ;

      IF sn_<>0 THEN
         dk_:=IIF_N(sn_,0,'1','2','2');
         kodp_:= dk_ || nbs_ || zz_ || mfo_ ;
         znap_:=TO_CHAR(ABS(se_));
         INSERT INTO rnbu_trace         -- ќстатки грн. + экв. валюты
                (nls, kv, odate, kodp, znap)
         VALUES  (nls_, kv_, data_, kodp_, znap_) ;
      END IF;
   END IF;
END LOOP;
CLOSE SaldoAOstfk;
---------------------------------------------------
---DELETE FROM tmp_nbu WHERE kodf='33' AND datf= Dat_;
DELETE FROM tmp_irep WHERE kodf='33' AND datf= Dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap)
   VALUES
        ('33', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_f33sbr;
/
show err;

PROMPT *** Create  grants  P_F33SBR ***
grant EXECUTE                                                                on P_F33SBR        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F33SBR.sql =========*** End *** 
PROMPT ===================================================================================== 
