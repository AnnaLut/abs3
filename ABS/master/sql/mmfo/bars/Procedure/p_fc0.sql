

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FC0.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FC0 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FC0 (Dat_ DATE )  IS
acc_     Number;
acc1_    Number;
dk_      Varchar2(1);
u_       Varchar2(1);
nbs_     Varchar2(4);
nls_     Varchar2(15);
nlsd_    Varchar2(15);
nlsk_    Varchar2(15);
Dat_ng   Date;
Dat1_    Date;
Dat2_    Date;
Dat3_    Date;
Dat3_ng  Date;
Dat4_    Date;
data_    Date;
data1_   Date;
kv_      SMALLINT;
kv1_     SMALLINT;
sn_      DECIMAL(24);
se_      DECIMAL(24);
Dos_     DECIMAL(24);
Kos_     DECIMAL(24);
Dosek_   DECIMAL(24);
Kosek_   DECIMAL(24);
kodp_    Varchar2(6);
znap_    Varchar2(30);
ddd_     Varchar(3);
userid_  Number;

--- остатки отчетного года
CURSOR SALDOOG IS
   SELECT a.acc, a.nls, a.kv, b.fdat, NVL(k.ddd,'00'),
         gl.p_icurval(a.kv, b.ostf-b.dos+b.kos, Dat_)
   FROM saldoa b, accounts a, kl_f3_29 k
   WHERE a.acc=b.acc                            AND
         a.nbs=k.r020                           AND
         k.kf='B9'                              AND
         (a.acc,b.fdat) =
         (select c.acc,max(c.fdat)
          from saldoa c
          where a.acc=c.acc and c.fdat <= Dat_
          group by c.acc) ;

--- Корректирующие проводки для счетов отсутствующих в конце месяца ---
CURSOR SALDOOGK IS
   SELECT s.acc, s.nls, s.kv, s.daos, s.nbs, NVL(k.ddd,'00'),
          NVL(SUM(DECODE(a.dk, 1, 1, -1)*a.s), 0)
   FROM  kor_prov a, accounts s, kl_f3_29 k
   WHERE s.nbs=k.r020                  AND
         k.kf='B9'                     AND
         a.fdat > Dat_                 AND
         a.fdat <= Dat2_               AND
         a.acc=s.acc                   AND
         a.vob=96                      AND
         s.daos > Dat_
  GROUP BY s.acc, s.nls, s.kv, s.daos, s.nbs, NVL(k.ddd,'00');

--- обороты отчетного года
CURSOR OBOROTYOG IS
   SELECT a.acc, a.nls, a.kv, b.fdat, NVL(k.ddd,'00'),
         SUM(NVL(gl.p_icurval(a.kv, b.dos, b.fdat),0)),
         SUM(NVL(gl.p_icurval(a.kv, b.kos, b.fdat),0))
   FROM saldoa b, accounts a, kl_f3_29 k
   WHERE a.acc=b.acc                            AND
         a.nbs=k.r020                           AND
         k.kf='B9'                              AND
         b.fdat > Dat_ng                        AND
         b.fdat <= TRUNC(Dat_-1)
   GROUP BY a.acc, a.nls, a.kv, b.fdat, NVL(k.ddd,'00');

--- обороты отчетного года
CURSOR PROVODKI IS
   SELECT nlsd, kv, fdat, s*100, nlsk
   FROM   provodki
   WHERE (nlsd=nls_ or nlsk=nls_)      AND
               kv=kv_                  AND
               fdat=data_ ;

--- остатки предыдущего года
CURSOR SALDOPG IS
   SELECT a.acc, a.nls, a.kv, b.fdat, NVL(k.ddd,'00'),
         gl.p_icurval(a.kv, b.ostf-b.dos+b.kos, Dat3_)
   FROM saldoa b, accounts a, kl_f3_29 k
   WHERE a.acc=b.acc         AND
         a.nbs=k.r020        AND
         k.kf='B9'           AND
         (a.acc,b.fdat) =
         (select c.acc,max(c.fdat)
          from saldoa c
          where a.acc=c.acc and c.fdat <= Dat3_
          group by c.acc) ;

--- Корректирующие проводки для счетов отсутствующих в конце предыдущего года ---
CURSOR SALDOPGK IS
   SELECT s.acc, s.nls, s.kv, s.daos, s.nbs, NVL(k.ddd,'00'),
          NVL(SUM(DECODE(a.dk, 1, 1, -1)*a.s), 0)
   FROM  kor_prov a, accounts s, kl_f3_29 k
   WHERE s.nbs=k.r020        AND
         k.kf='B9'           AND
         a.fdat > Dat3_      AND
         a.fdat <= Dat4_     AND
         a.acc=s.acc         AND
         a.vob=96            AND
         s.daos > Dat3_
  GROUP BY s.acc, s.nls, s.kv, s.daos, s.nbs, NVL(k.ddd,'00');

--- обороты предыдущего года
CURSOR OBOROTYPG IS
   SELECT a.acc, a.nls, a.kv, b.fdat, NVL(k.ddd,'00'),
         SUM(NVL(gl.p_icurval(a.kv, b.dos, b.fdat),0)),
         SUM(NVL(gl.p_icurval(a.kv, b.kos, b.fdat),0))
   FROM saldoa b, accounts a, kl_f3_29 k
   WHERE a.acc=b.acc                            AND
         a.nbs=k.r020                           AND
         k.kf='B9'                              AND
         b.fdat > Dat3_ng                       AND
         b.fdat <= TRUNC(Dat3_-1)
   GROUP BY a.acc, a.nls, a.kv, b.fdat, NVL(k.ddd,'00');

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
Dat_ng:=to_date('01' || '01' ||to_char(Dat_,'YYYY'),'DDMMYYYY');

data_:=to_date('31' || '12' ||
               to_char(to_number(to_char(Dat_,'YYYY'))-1),'DDMMYYYY');

Dat3_ng:=to_date('01' || '01' ||
               to_char(to_number(to_char(Dat_,'YYYY'))-1),'DDMMYYYY');

SELECT max(Fdat) INTO Dat3_ FROM FDAT WHERE fdat<=data_;

Dat4_:=TRUNC(Dat3_ + 28);
--------------------- Корректирующие проводки ---------------------
---TRUNCATE TABLE kor_prov ;
DELETE FROM ref_kor ;
---IF to_char(Dat_,'MM')='12' THEN
---   INSERT INTO ref_kor (REF, VOB, VDAT)
---   SELECT ref, vob, vdat
---   FROM oper
---   WHERE (vob=96 OR vob=99) AND tt NOT LIKE 'ZG%' AND
---          not (((substr(nlsa,1,1)='6' or substr(nlsa,1,1)='7')
---          and substr(nlsb,1,4)='5040') or (substr(nlsa,1,4)='5040' and
---          (substr(nlsb,1,1)='6' or substr(nlsb,1,1)='7'))) ;
---ELSE
   INSERT INTO ref_kor (REF, VOB, VDAT)
   SELECT ref, vob, vdat
   FROM oper
   WHERE vob=96 OR vob=99 ;
---END IF ;

DELETE FROM kor_prov ;
INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
SELECT o.ref, o.dk, o.acc, o.s, o.fdat, p.vdat, o.sos, p.vob
FROM opldok o, ref_kor p     --- oper p
WHERE o.fdat>Dat_ng    AND
      o.fdat<=Dat2_    AND
      o.ref=p.ref      AND
      o.sos=5 ;
-------------------------------------------------------------------
--- остатки отчетного года
OPEN SALDOOG;
LOOP
   FETCH SALDOOG INTO acc_, nls_, kv_, data_, ddd_, sn_;
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

   IF sn_ <> 0 THEN
      dk_:=IIF_N(sn_,0,'1','2','2');
      kodp_:= dk_ || RTRIM(ddd_) || 'H' || '10' ;
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
   FETCH SALDOOGK INTO acc_, nls_, kv_, data_, Nbs_, ddd_, Kosek_ ;
   EXIT WHEN SALDOOGK%NOTFOUND;

   Kosek_:=gl.p_icurval(kv_, Kosek_, Dat_);

   IF Kosek_<>0 THEN
      dk_:=IIF_N(Kosek_,0,'1','2','2');
      kodp_:= dk_ || RTRIM(ddd_) || 'H' || '10' ;
      znap_:= TO_CHAR(ABS(Kosek_));
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
   END IF;

END LOOP;
CLOSE SALDOOGK;
-----------------------------------------------------------------------------
--- обороты отчетного года
OPEN OBOROTYOG;
LOOP
   FETCH OBOROTYOG INTO acc_, nls_, kv_, data_, ddd_, Dos_, Kos_;
   EXIT WHEN OBOROTYOG%NOTFOUND;

   nbs_:=substr(nls_,1,4);

   IF to_char(data_,'MM')='01' THEN
--- отбор корректирующих проводок отчетного месяца
      BEGIN
         SELECT d.acc,
            SUM(DECODE(d.dk, 0, GL.P_ICURVAL(kv_, d.s, Dat3_), 0)),
            SUM(DECODE(d.dk, 1, GL.P_ICURVAL(kv_, d.s, Dat3_), 0))
         INTO acc1_, Dosek_, Kosek_
         FROM  kor_prov d
         WHERE d.acc=acc_                   AND
               d.fdat=data_                 AND
---               d.fdat > Dat_ng              AND
---               d.fdat <= Dat_               AND
               d.vob=96
         GROUP BY d.acc ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         Dosek_ :=0 ;
         Kosek_ :=0 ;
      END ;
      Dos_:=Dos_-Dosek_;
      Kos_:=Kos_-Kosek_;
   END IF;

   u_:='2';

   IF substr(nbs_,1,4)='5010' THEN
      u_:='C';
      OPEN PROVODKI;
           LOOP
           FETCH PROVODKI INTO  nlsd_, kv1_, data1_, se_, nlsk_;
           EXIT WHEN PROVODKI%NOTFOUND;
           IF substr(nlsd_,1,4)='5002' OR substr(nlsk_,1,4)='5002' THEN
              u_:='E';
           END IF;
      END LOOP;
      CLOSE PROVODKI;
   END IF;

   IF substr(nbs_,1,3) in ('503','504') THEN
      u_:='2';

      OPEN PROVODKI;
           LOOP
           FETCH PROVODKI INTO  nlsd_, kv1_, data1_, se_, nlsk_;
           EXIT WHEN PROVODKI%NOTFOUND;

           IF substr(nlsd_,1,4)='5010' OR substr(nlsk_,1,4)='5010' THEN
              u_:='E';
           END IF;
           IF substr(nlsd_,1,4)='5020' OR substr(nlsk_,1,4)='5020' THEN
              u_:='7';
           END IF;
           IF substr(nlsd_,1,4)='5021' OR substr(nlsk_,1,4)='5021' THEN
              u_:='8';
           END IF;
           IF substr(nlsd_,1,4)='5022' OR substr(nlsk_,1,4)='5022' THEN
              u_:='9';
           END IF;

      END LOOP;
      CLOSE PROVODKI;
   END IF;

   IF substr(nbs_,1,3)='510' THEN
      u_:='4';
   END IF;

   IF nbs_='5020' THEN
      u_:='7';
   END IF;
   IF nbs_='5021' THEN
      u_:='8';
   END IF;
   IF nbs_='5022' THEN
      u_:='9';
      OPEN PROVODKI;
           LOOP
           FETCH PROVODKI INTO  nlsd_, kv1_, data1_, se_, nlsk_;
           EXIT WHEN PROVODKI%NOTFOUND;
---           IF substr(nlsd_,1,3) in ('503','504') OR substr(nlsk_,1,3) in ('503','504') THEN
---              u_:='B';
---           END IF;
           IF substr(nlsd_,1,4)='5002' OR substr(nlsk_,1,4)='5002' THEN
              u_:='E';
           END IF;
      END LOOP;
      CLOSE PROVODKI;
   END IF;
   IF nbs_='5003' THEN
      u_:='B';
      OPEN PROVODKI;
           LOOP
           FETCH PROVODKI INTO  nlsd_, kv1_, data1_, se_, nlsk_;
           EXIT WHEN PROVODKI%NOTFOUND;

           IF substr(nlsd_,1,3) in ('503','504') OR substr(nlsk_,1,3) in ('503','504') THEN
              u_:='B';
           END IF;
           IF substr(nlsd_,1,4) in ('5000','5010') OR substr(nlsk_,1,4) in ('5000','5010') THEN
              u_:='D';
           END IF;
      END LOOP;
      CLOSE PROVODKI;
   END IF;
   IF nbs_ in ('5000','5001') THEN
      u_:='C';
      OPEN PROVODKI;
           LOOP
           FETCH PROVODKI INTO  nlsd_, kv1_, data1_, se_, nlsk_;
           EXIT WHEN PROVODKI%NOTFOUND;
           IF substr(nlsd_,1,4)='5002' OR substr(nlsk_,1,4)='5002' THEN
              u_:='G';
           END IF;
      END LOOP;
      CLOSE PROVODKI;
   END IF;
   IF nbs_ in ('5002') THEN
      u_:='E';
      OPEN PROVODKI;
           LOOP
           FETCH PROVODKI INTO  nlsd_, kv1_, data1_, se_, nlsk_;
           EXIT WHEN PROVODKI%NOTFOUND;
           IF substr(nlsd_,1,4) in('5000','5001') OR substr(nlsk_,1,4) in ('5000','5001') THEN
              u_:='G';
           END IF;
           IF substr(nlsd_,1,4)='5010' OR substr(nlsk_,1,4)='5010' THEN
              u_:='F';
           END IF;
      END LOOP;
      CLOSE PROVODKI;
   END IF;

   IF Dos_ <> 0 THEN
      kodp_:= '5' || RTRIM(ddd_) || u_ || '10' ;
      znap_:= TO_CHAR(ABS(Dos_));
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
   END IF;
   IF Kos_ <> 0 THEN
      kodp_:= '6' || RTRIM(ddd_) || u_ || '10' ;
      znap_:= TO_CHAR(ABS(Kos_));
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
   END IF;
END LOOP;
CLOSE OBOROTYOG;
-----------------------------------------------------------------------------
--- предыдущий год

DELETE FROM kor_prov ;
INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
SELECT o.ref, o.dk, o.acc, o.s, o.fdat, p.vdat, o.sos, p.vob
FROM opldok o, ref_kor p     --- oper p
WHERE o.fdat>Dat3_ng   AND
      o.fdat<=Dat4_    AND
      o.ref=p.ref      AND
      o.sos=5 ;

--- остатки предыдущего года
OPEN SALDOPG;
LOOP
   FETCH SALDOPG INTO acc_, nls_, kv_, data_, ddd_, sn_;
   EXIT WHEN SALDOPG%NOTFOUND;

   nbs_:=substr(nls_,1,4);

--- отбор корректирующих проводок предыдущего месяца
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

   IF sn_ <> 0 THEN
      dk_:='2';
---      dk_:=IIF_N(sn_,0,'1','2','2');
      kodp_:= dk_ || '08' || '0' || '20' ;
      znap_:=TO_CHAR(sn_);
---      znap_:= TO_CHAR(ABS(sn_));
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
   END IF;
END LOOP;
CLOSE SALDOPG;
-----------------------------------------------------------------------------
--- Остатки сформиров. по корр.проводкам для сч. отсутств. в конце  ---
--- предыдущего года
OPEN SALDOPGK;
   LOOP
   FETCH SALDOPGK INTO acc_, nls_, kv_, data_, Nbs_, ddd_, Kosek_ ;
   EXIT WHEN SALDOPGK%NOTFOUND;

   Kosek_:=gl.p_icurval(kv_, Kosek_, Dat3_);

   IF Kosek_<>0 THEN
      dk_:='2';
---      dk_:=IIF_N(Kosek_,0,'1','2','2');
      kodp_:= dk_ || '08' || '0' || '20' ;
      znap_:=TO_CHAR(Kosek_);
---      znap_:= TO_CHAR(ABS(Kosek_));
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
   END IF;
END LOOP;
CLOSE SALDOPGK;
----------------------------------------------------------------------------
--- обороты предыдущего года
OPEN OBOROTYPG;
LOOP
   FETCH OBOROTYPG INTO acc_, nls_, kv_, data_, ddd_, Dos_, Kos_;
   EXIT WHEN OBOROTYPG%NOTFOUND;

   IF to_char(data_,'MM')='01' THEN
--- отбор корректирующих проводок предыдущего года
      BEGIN
         SELECT d.acc,
            SUM(DECODE(d.dk, 0, GL.P_ICURVAL(kv_, d.s, Dat_), 0)),
            SUM(DECODE(d.dk, 1, GL.P_ICURVAL(kv_, d.s, Dat_), 0))
         INTO acc1_, Dosek_, Kosek_
         FROM  kor_prov d
         WHERE d.acc=acc_                   AND
               d.fdat=data_                 AND
---               d.fdat > Dat3_ng             AND
---               d.fdat <= Dat3_              AND
               d.vob = 96
         GROUP BY d.acc ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         Dosek_ :=0 ;
         Kosek_ :=0 ;
      END ;
      Dos_:=Dos_-Dosek_;
      Kos_:=Kos_-Kosek_;
   END IF;

   IF Dos_ <> 0 THEN
      kodp_:= '5' || '08' || '2' || '20' ;
      znap_:= TO_CHAR(ABS(Dos_));
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
   END IF;
   IF Kos_ <> 0 THEN
      kodp_:= '6' || '08' || '2' || '20' ;
      znap_:= TO_CHAR(ABS(Kos_));
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
   END IF;
END LOOP;
CLOSE OBOROTYPG;
----------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_nbu where kodf='C0' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('C0', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
----------------------------------------
END p_fC0;
/
show err;

PROMPT *** Create  grants  P_FC0 ***
grant EXECUTE                                                                on P_FC0           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FC0           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FC0.sql =========*** End *** ===
PROMPT ===================================================================================== 
