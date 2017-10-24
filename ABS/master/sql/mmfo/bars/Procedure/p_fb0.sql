

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FB0.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FB0 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FB0 (Dat_ DATE ) IS

acc_    Number;
acc1_    Number;
acc2_    Number;
dat1_   Date;
dat2_   Date;
mm_     Varchar2(2);
dd_     Varchar2(2);
Dosn_   DECIMAL(24);
Dose_   DECIMAL(24);
Kosn_   DECIMAL(24);
Kose_   DECIMAL(24);
Dosnk_  DECIMAL(24);
Dosek_  DECIMAL(24);
Kosnk_  DECIMAL(24);
Kosek_  DECIMAL(24);
se_     DECIMAL(24);
sn_     DECIMAL(24);
Dosnkg_  DECIMAL(24);
Dosekg_  DECIMAL(24);
Kosnkg_  DECIMAL(24);
Kosekg_  DECIMAL(24);
Ostn_   DECIMAL(24);
Oste_   DECIMAL(24);
kodp_   varchar2(10);
znap_   varchar2(30);
Kv_     SMALLINT;
Vob_    SMALLINT;
Nbs_    varchar2(4);
nls_    varchar2(15);
data_   date;
r031_   char(1);
f01_    Number;
dk_     char(1);
nbu_    SMALLINT;
prem_   char(3);
userid_ Number;

---Обороты (по грн. + по валюте номиналы)
CURSOR SaldoASeekOs IS
   SELECT /* + INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */
          a.acc, a.nls, a.kv, a.nbs, l.r031, to_char(s.fdat,'MM'),
          SUM(GL.P_ICURVAL(a.kv, s.Dos, s.fdat)),
          SUM(GL.P_ICURVAL(a.kv, s.Kos, s.fdat))
   FROM saldoa s, accounts a, cust_acc ca, customer c, kl_r030 l
   WHERE ((substr(a.nbs,1,2)='20' and
           to_number(substr(a.nbs,4,1))<8) OR
          (substr(a.nbs,1,2)='20' and a.nbs='2099'))  AND
         s.fdat > Dat1_                AND
         s.fdat<= Dat_                 AND
         a.acc=ca.acc                  AND
         s.acc=ca.acc                  AND
         ca.rnk=c.rnk                  AND
         MOD(c.codcagent,2) <> 0       AND
         a.kv=TO_NUMBER(l.r030)        AND
         (l.r031=2 or (l.r031=3 and a.kv=810))
   GROUP BY a.acc, a.nls, a.kv, a.nbs, l.r031, to_char(s.fdat,'MM');

--- Корректирующие проводки для счетов отсутствующих в конце месяца ---
CURSOR SaldoAOstfk IS
   SELECT s.nls, s.kv, s.daos, s.nbs, l.r031,
          SUM(DECODE(a.dk, 0, a.s, 0)),
          SUM(DECODE(a.dk, 1, a.s, 0))
   FROM  kor_prov a, accounts s, cust_acc ca, customer c, kl_r030 l
   WHERE ((substr(s.nbs,1,2)='20' and
           to_number(substr(s.nbs,4,1))<8) OR
          (substr(s.nbs,1,2)='20' and s.nbs='2099'))  AND
         a.fdat > Dat_                 AND
         a.fdat <= Dat2_               AND
         a.acc=s.acc                   AND
         s.daos > Dat_                 AND
         a.acc=ca.acc                  AND
         c.rnk=ca.rnk                  AND
         MOD(c.codcagent,2) <> 0       AND
         s.kv=TO_NUMBER(l.r030)        AND
         (l.r031=2 or (l.r031=3 and s.kv=810))  AND
         a.vob=96
   GROUP BY s.nls, s.kv, s.daos, s.nbs, l.r031;

--- кредити, проданi на валютному ринку Украiни за гривню
CURSOR OPL_DOK IS
    SELECT o.accd, o.nlsd, o.kv, l.r031, to_char(o.fdat,'MM'),
           SUM(GL.P_ICURVAL(o.kv, o.s*100, o.fdat))
    FROM  provodki o, accounts s, cust_acc ca, customer c, kl_r030 l
    WHERE  ((substr(o.nlsd,1,2)='20' and
           to_number(substr(o.nlsd,4,1))<8) OR
          (substr(o.nlsd,1,2)='20' and substr(o.nlsd,1,4)='2099'))    AND
          (o.nlsk='290079000840' OR o.nlsk='29008302')                AND
           o.fdat > Dat1_                       AND
           o.fdat <= Dat_                       AND
           o.accd=s.acc                         AND
           s.acc=ca.acc                         AND
           c.rnk=ca.rnk                         AND
           MOD(c.codcagent,2) <> 0              AND
           o.kv=TO_NUMBER(l.r030)               AND
         (l.r031=2 or (l.r031=3 and s.kv=810))
   GROUP BY o.accd, o.nlsd, o.kv, o.fdat, l.r031, to_char(o.fdat,'MM') ;

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
nbu_:= IsNBUBank();
IF nbu_=1 THEN
   prem_:= '═┴╙';
ELSE
   prem_:= '╩┴ ';
END IF;

---Dat1_ := TRUNC(Dat_ - TO_NUMBER(TO_CHAR(Dat_,'DD')));
---Dat1_:=TO_DATE('17-11-2000','DD-MM-YYYY');
Dat1_:=to_date('0101' || to_char(Dat_,'YYYY'),'DDMMYYYY') ;
Dat2_ := TRUNC(Dat_ + 28);

--------------------- Корректирующие проводки ---------------------
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
COMMIT;
-------------------------------------------------------------------
-- Обороты текущие (грн. + вал. номиналы ) --
OPEN SaldoASeekOs;
LOOP
    FETCH SaldoASeekOs INTO acc_, nls_, kv_, Nbs_, r031_, mm_, Dosn_, Kosn_ ;
    EXIT WHEN SaldoASeekOs%NOTFOUND;
    IF (mm_='04' or mm_='06' or mm_='09' or mm_='11') THEN
       dd_:='30';
    ELSE
       dd_:='31';
    END IF;
    IF mm_='02' THEN
       dd_:='28';
    END IF;

    Data_:=to_date(dd_ || mm_ || to_char(Dat_,'YYYY'),'DDMMYYYY') ;

--- отбор корректирующих проводок месяца предшествующего отчетному
---    BEGIN
---       SELECT a.acc,
---           SUM(DECODE(a.dk, 0, a.s, 0)),
---           SUM(DECODE(a.dk, 1, a.s, 0))
---       INTO acc1_, Dosnk_, Kosnk_
---       FROM kor_prov a
---       WHERE a.acc=acc_                   AND
---             a.fdat > Dat1_               AND
---             a.fdat <= Dat_               AND
---             a.vob=96
---       GROUP BY a.acc ;
---    EXCEPTION WHEN NO_DATA_FOUND THEN
---       Dosnk_ :=0 ;
---       Kosnk_ :=0 ;
---    END ;

---   Dosn_ := Dosn_-Dosnk_ ;
---   Kosn_ := Kosn_-Kosnk_ ;

---   IF kv_ <> 980 THEN
---      Dose_ := GL.P_ICURVAL(kv_, Dosn_, Dat_) ;
---      Kose_ := GL.P_ICURVAL(kv_, Kosn_, Dat_) ;
---   ELSE
      Dose_ := Dosn_ ;
      Kose_ := Kosn_ ;
---   END IF ;

   IF Dose_ > 0 and substr(nbs_,4,1)<>'6' and substr(nbs_,4,1)<>'7'
                    and nbs_<>'2095' THEN
      kodp_:='01' || r031_ || mm_ ;
      znap_:=TO_CHAR(Dose_);
      INSERT INTO rnbu_trace     -- Дб. обороты в номинале валюты (грн.+вал.)
              (nls, kv, odate, kodp, znap)
      VALUES  (nls_, kv_, data_, kodp_, znap_) ;
   END IF;

---   IF (Dose_ > 0  OR Kose_ > 0) THEN
---      kodp_:='02' || r031_ || mm_ ;
---      znap_:='0' ;
---      INSERT INTO rnbu_trace     -- Код 02 с пустым значением
---              (nls, kv, odate, kodp, znap)
---      VALUES  (nls_, kv_, data_, kodp_, znap_) ;
---   END IF;

   IF Kose_ > 0 THEN
      kodp_:='03' || r031_ || mm_ ;
      znap_:=TO_CHAR(Kose_) ;
      INSERT INTO rnbu_trace     -- Кр. обороты в номинале валюты (грн.+вал.)
              (nls, kv, odate, kodp, znap)
      VALUES  (nls_, kv_, data_, kodp_, znap_) ;
   END IF;
END LOOP;
CLOSE SaldoASeekOs;
-------------------------------------------------------------------------
-- Обороты текущие (грн. + вал. номиналы ) --
OPEN OPL_DOK;
LOOP
    FETCH OPL_DOK INTO acc_, nls_, kv_, r031_, mm_, Dosn_ ;
    EXIT WHEN OPL_DOK%NOTFOUND;
    IF (mm_='04' or mm_='06' or mm_='09' or mm_='11') THEN
       dd_:='30';
    ELSE
       dd_:='31';
    END IF;
    IF mm_='02' THEN
       dd_:='28';
    END IF;

    Data_:=to_date(dd_ || mm_ || to_char(Dat_,'YYYY'),'DDMMYYYY') ;

      Dose_ := Dosn_ ;

   IF Dose_ > 0 THEN
      kodp_:='02' || r031_ || mm_ ;
      znap_:=TO_CHAR(Dose_);
      INSERT INTO rnbu_trace     -- Дб. обороты в номинале валюты (грн.+вал.)
              (nls, kv, odate, kodp, znap)
      VALUES  (nls_, kv_, data_, kodp_, znap_) ;
   END IF;
END LOOP;
CLOSE OPL_DOK;
-----------------------------------------------------------------------------
--- Обороты сформиров. по корр.проводкам для сч. отсутств. в конце месяца ---
---OPEN SaldoAOstfk;
---   LOOP
---   FETCH SaldoAOstfk INTO nls_, kv_, data_, Nbs_, r031_, Dosn_, Kosn_ ;
---   EXIT WHEN SaldoAOstfk%NOTFOUND;

---   IF kv_ <> 980 THEN
---      Dose_ := GL.P_ICURVAL(kv_, Dosn_, Dat_) ;
---      Kose_ := GL.P_ICURVAL(kv_, Kosn_, Dat_) ;
---   ELSE
---      Dose_ := Dosn_ ;
---      Kose_ := Kosn_ ;
---   END IF ;

---   IF Dose_<>0 THEN
---      kodp_:= '01' || r031_ || '12' ;
---      znap_:=TO_CHAR(ABS(Dose_));

---      INSERT INTO rnbu_trace         -- Дт обороты в эквиваленте валюты
---              (nls, kv, odate, kodp, znap)
---      VALUES  (nls_, kv_, data_, kodp_, znap_) ;
---   END IF;

---   IF Kose_<>0 THEN
---      kodp_:= '03' || r031_ || '12' ;
---      znap_:=TO_CHAR(ABS(Kose_));
---      INSERT INTO rnbu_trace         -- Кт обороты в эквиваленте валюты
---              (nls, kv, odate, kodp, znap)
---      VALUES  (nls_, kv_, data_, kodp_, znap_) ;
---   END IF;
---END LOOP;
---CLOSE SaldoAOstfk;
-----------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_nbu where kodf='B0' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('B0', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_fB0;
/
show err;

PROMPT *** Create  grants  P_FB0 ***
grant EXECUTE                                                                on P_FB0           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FB0           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FB0.sql =========*** End *** ===
PROMPT ===================================================================================== 
