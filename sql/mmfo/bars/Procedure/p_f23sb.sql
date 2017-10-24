

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F23SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F23SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F23SB (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   :	otcn.sql
% DESCRIPTION :	ќтчетность —берЅанка: формирование файлов
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     : 23.02.2009
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
nbs_     varchar2(4);
nbs1_    Varchar2(4);
kv_      SMALLINT;
nls_     varchar2(15);
data_    date;
dat1_    Date;
dat2_    Date;
Dosnk_   DECIMAL(24);
Dosek_   DECIMAL(24);
Kosnk_   DECIMAL(24);
Kosek_   DECIMAL(24);
s0000_   varchar2(15);
s0009_   varchar2(15);
zz_      Varchar2(4);
sn_      DECIMAL(24);
se_      DECIMAL(24);
dk_      char(1);
kodp_    varchar2(10);
znap_    varchar2(30);
acc_     Number;
acc1_    Number;
kolu_    Number;
userid_  Number;

--ќстатки номиналы (грн.+валюта)
CURSOR SALDO IS
   SELECT a.nls, a.kv, a.nbs, a.fdat, k.ob88,
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
         customer c, cust_acc ca, sb_ob88 k
   WHERE a.acc=ca.acc              AND
         ca.rnk=c.rnk              AND
         a.nbs=k.r020              AND
         k.a010='23' ;        ---  AND
---         a.ostf-a.dos+a.kos <> 0 ;

--ќстатки сч. тех. переоценки и валютные эквиваленты
CURSOR SALDOQ IS
   SELECT a.nls, a.kv, a.nbs, a.fdat, k.ob88,
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
         customer c, cust_acc ca, sb_ob88 k
   WHERE a.acc=ca.acc              AND
         ca.rnk=c.rnk              AND
         a.nbs=k.r020              AND
         k.a010='23' ;        ---  AND
---         a.ostf-a.dos+a.kos <> 0 ;
-----------------------------------------------------------------------
---  орректирующие проводки дл€ счетов отсутствующих в конце мес€ца ---
CURSOR SaldoAOstfk IS
   SELECT s.acc, s.nls, s.kv, s.daos, s.nbs, k.ob88,
          SUM(DECODE(a.dk, 0, a.s, 0)),
---          SUM(DECODE(a.dk, 0, GL.P_ICURVAL(s.kv, a.s, Dat_), 0)),
          SUM(DECODE(a.dk, 1, a.s, 0))
---          SUM(DECODE(a.dk, 1, GL.P_ICURVAL(s.kv, a.s, Dat_), 0))
   FROM  kor_prov a, accounts s, cust_acc ca, customer c, sb_ob88 k
   WHERE a.fdat > Dat_                 AND
         a.fdat <= Dat2_               AND
         a.acc=s.acc                   AND
         s.daos > Dat_                 AND
         a.acc=ca.acc                  AND
         c.rnk=ca.rnk                  AND
         s.nbs=k.r020                  AND
         k.a010='23'                   AND
         a.vob=96
   GROUP BY s.acc, s.nls, s.kv, s.daos, s.nbs, k.ob88 ;
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
---Dat1_:=TO_DATE('17-11-2000','DD-MM-YYYY');
Dat2_ := TRUNC(Dat_ + 28);
---------------------  орректирующие проводки ---------------------
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
kolu_ := 0 ;
nbs1_ := '0000' ;
OPEN SALDO;
LOOP
   FETCH SALDO INTO nls_, kv_, nbs_, data_, zz_, sn_ ;
   EXIT WHEN SALDO%NOTFOUND;
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


   nbs1_:= IIF_S(nbs1_,'0000',nbs_,nbs1_,nbs1_);
   IF kolu_<>0 and nbs1_<>nbs_ and to_number(nbs_)<8600 THEN
      kodp_:= '3' || nbs_ || zz_ ;
      znap_:= TO_CHAR(ABS(sn_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_,znap_) ;
      kolu_:=0;
      nbs1_:=nbs_;
   END IF;

   sn_:=sn_-Dosnk_+Kosnk_ ;
   IF sn_<>0 THEN
      dk_:=IIF_N(sn_,0,'1','2','2');
      kodp_:= dk_ || nbs_ || zz_ ;
      znap_:= TO_CHAR(ABS(sn_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_,znap_) ;
      kolu_:=kolu_+1;
   END IF;
END LOOP;
CLOSE SALDO;
---------------------------------------------------------------------
kolu_ := 0 ;
nbs1_ := '0000' ;

OPEN SALDOQ;
LOOP
   FETCH SALDOQ INTO nls_, kv_, nbs_, data_, zz_, sn_ ;
   EXIT WHEN SALDOQ%NOTFOUND;
   s0000_:= '0' ;
   s0009_:= '0' ;
--- отбор корректирующих проводок отчетного мес€ца
   BEGIN
      SELECT d.acc,
         SUM(DECODE(d.dk, 0, GL.P_ICURVAL(kv_, d.s, Dat_), 0)),
         SUM(DECODE(d.dk, 1, GL.P_ICURVAL(kv_, d.s, Dat_), 0))
---         SUM(DECODE(d.dk, 0, d.s, 0))
---         SUM(DECODE(d.dk, 1, d.s, 0))
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
      SELECT s0000, s0009 INTO s0000_, s0009_
      FROM tabval WHERE kv=kv_ and (s0000=nls_ or s0009=nls_) ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      s0000_ := '0' ;
      s0009_ := '0' ;
   END ;

   nbs1_:= IIF_S(nbs1_,'0000',nbs_,nbs1_,nbs1_);
   IF kolu_<>0 and nbs1_<>nbs_ and to_number(nbs_)<8600 THEN
      kodp_:= '3' || nbs_ || zz_ ;
      znap_:= TO_CHAR(ABS(sn_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_,znap_) ;
      kolu_:=0;
      nbs1_:=nbs_;
   END IF;

   sn_:=sn_-Dosnk_+Kosnk_ ;
   IF sn_<>0 THEN
      dk_:=IIF_N(sn_,0,'1','2','2');
      kodp_:= dk_ || nbs_ || zz_ ;
      znap_:= TO_CHAR(ABS(sn_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_,znap_);
      kolu_:=kolu_+1;
   END IF;
END LOOP;
CLOSE SALDOQ;
-----------------------------------------------------------------------------
--- ќстатки сформиров. по корр.проводкам дл€ сч. отсутств. в конце мес€ца ---
OPEN SaldoAOstfk;
   LOOP
   FETCH SaldoAOstfk INTO acc_, nls_, kv_, data_, Nbs_, zz_, Dosnk_, Kosnk_ ;
   EXIT WHEN SaldoAOstfk%NOTFOUND;

   sn_:=Kosnk_-Dosnk_ ;
   IF kv_ <> 980 THEN
      se_ := GL.P_ICURVAL(kv_, sn_, Dat_) ;
   ELSE
      se_ := sn_ ;
   END IF ;

   IF sn_<>0 THEN
      dk_:=IIF_N(sn_,0,'1','2','2');
      kodp_:= dk_ || nbs_ || zz_ ;
      znap_:=TO_CHAR(ABS(se_));
      INSERT INTO rnbu_trace         -- ќстатки грн. + экв. валюты
             (nls, kv, odate, kodp, znap)
      VALUES  (nls_, kv_, data_, kodp_, znap_) ;
   END IF;
END LOOP;
CLOSE SaldoAOstfk;
-----------------------------------------------------------------------------
---------------------------------------------------
---DELETE FROM tmp_nbu WHERE kodf='23' AND datf= Dat_;
DELETE FROM tmp_irep WHERE kodf='23' AND datf= Dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap)
   VALUES
        ('23', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_f23sb;
 
/
show err;

PROMPT *** Create  grants  P_F23SB ***
grant EXECUTE                                                                on P_F23SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F23SB         to RPBN002;
grant EXECUTE                                                                on P_F23SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F23SB.sql =========*** End *** =
PROMPT ===================================================================================== 
