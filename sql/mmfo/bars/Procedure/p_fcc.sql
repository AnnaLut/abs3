

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FCC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FCC ***

  CREATE OR REPLACE PROCEDURE BARS.P_FCC (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования файла FCC для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :	09.01.2009 (15.01.2008, предыдущая версия от 10.08.2006)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Изменения:
   ----------
09.01.2009 не берем вклады по металлам (959-золото, 961-серебро,
                                        962-платина,964-паладий)
           для бал.счета 2903 будут выбираться клиенты только физ.лица
           (codcagent in ('5','6'))
15.01.2008 для счетов депозитных сертифткатов 3 класс будут
           выбираться клиенты только физ.лица (codcagent in ('5','6'))
10.08.2006 работает по кл-ру KL_F3_29 (KF='CC').
           Для бал.счета 2909 выбираются только те лицевые счета,
           которые указаны в поле TXT классификатора KL_F3_29
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
acc_     Number;
acc1_    Number;
acc3_    Number;
nbs_     Varchar2(4);
nls_     Varchar2(15);
nls1_    Varchar2(15);
data_    Date;
dat1_    Date;
dat2_    Date;
sn_      DECIMAL(24);
se_      DECIMAL(24);
Dosn_    DECIMAL(24);
Kosn_    DECIMAL(24);
Dosek_   DECIMAL(24);
Kosek_   DECIMAL(24);
Kv_      Number;
kodp_    Varchar2(11);
kodp1_   Varchar2(11);
znap_    Varchar2(30);
znap1_   Varchar2(30);
itog_    Number;
userid_  Number;

--- остатки по грн. и эквиваленты по валюте
CURSOR SALDO IS
   SELECT s.acc, s.nls, s.kv, a.fdat, s.nbs, a.ostf-a.dos+a.kos
   FROM saldoa a, accounts s, kl_f3_29 k, cust_acc ca, customer c
   WHERE a.acc=s.acc
     AND s.acc=ca.acc
     AND ca.rnk=c.rnk
     AND (s.acc,a.fdat) =
         (select c.acc,max(c.fdat)
          from saldoa c
          where s.acc=c.acc and c.fdat <= Dat_
          group by c.acc)
     AND s.kv=980
     AND s.nbs=k.r020
     AND k.kf='CC'
     AND ((s.nbs not in ('2620','2625') and a.ostf-a.dos+a.kos<>0) OR
         (s.nbs in ('2620','2625') and a.ostf-a.dos+a.kos>0))
     AND ((substr(s.nbs,1,1)='3' and c.codcagent in (5,6) and
           trim(c.sed)<>'91') OR (substr(s.nbs,1,1) not in ('3')))
     AND ((s.nbs in ('2903','2909') and c.codcagent in (5,6) and
           trim(c.sed)<>'91') OR (s.nbs not in ('2903','2909'))) ;

--- остатки по эквивалентам
CURSOR SALDOQ IS
   SELECT s.acc, s.nls, s.kv, a.fdat, s.nbs, a.ostf-a.dos+a.kos
   FROM saldob a, accounts s, kl_f3_29 k, cust_acc ca, customer c
   WHERE a.acc=s.acc
     AND s.kv not in (959,961,962,964)
     AND s.acc=ca.acc
     AND ca.rnk=c.rnk
     AND (s.acc,a.fdat) =
         (select c.acc,max(c.fdat)
          from saldob c
          where s.acc=c.acc and c.fdat <= Dat_
          group by c.acc)
     AND s.nbs=k.r020
     AND k.kf='CC'
     AND ((s.nbs not in ('2620','2625') and a.ostf-a.dos+a.kos<>0) OR
         (s.nbs in ('2620','2625') and a.ostf-a.dos+a.kos>0))
     AND ((substr(s.nbs,1,1)='3' and c.codcagent in (5,6) and
          trim(c.sed)<>'91') OR (substr(s.nbs,1,1) not in ('3')))
     AND ((s.nbs in ('2903','2909') and c.codcagent in (5,6) and
          trim(c.sed)<>'91') OR (s.nbs not in ('2903','2909'))) ;

--- Корректирующие проводки для счетов отсутствующих в конце месяца ---
CURSOR SALDOK IS
   SELECT s.acc, s.nls, s.kv, s.daos, s.nbs,
          NVL(SUM(DECODE(a.dk, 1, 1,-1)*a.s), 0)
   FROM  opldok a, accounts s, oper o, kl_f3_29 k
   WHERE a.ref=o.ref                   AND
         o.vob=96                      AND
         o.sos=5                       AND
         a.fdat > Dat_                 AND
         a.fdat <= Dat2_               AND
         a.acc=s.acc                   AND
         s.daos > Dat_                 AND
         s.nbs=k.r020                  AND
         s.kv not in (959,961,962,964) AND
         k.kf='CC'
   GROUP BY s.acc, s.nls, s.kv, s.daos, s.nbs ;

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
itog_:=0;
Dat1_ := TRUNC(Dat_ - TO_NUMBER(TO_CHAR(Dat_,'DD')));
---Dat1_:=TO_DATE('17-11-2000','DD-MM-YYYY');
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
WHERE o.fdat>Dat_      AND
      o.fdat<=Dat2_    AND
      o.ref=p.ref      AND
      o.sos=5 ;
---where o.ref=p.ref and p.vob>95 and o.sos=5;
---COMMIT;
-------------------------------------------------------------------
OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_, nls_, Kv_, data_, nbs_, sn_ ;
   EXIT WHEN SALDO%NOTFOUND;

--- отбор корректирующих проводок отчетного месяца
    BEGIN
       SELECT d.acc, NVL(SUM(DECODE(d.dk, 1, 1,-1)*d.s), 0)
       INTO acc3_, Dosn_
       FROM  kor_prov d
       WHERE d.acc=acc_                   AND
             d.fdat > Dat_                AND
             d.fdat <= Dat2_              AND
             d.vob = 96
       GROUP BY d.acc ;
    EXCEPTION WHEN NO_DATA_FOUND THEN
       Dosn_ :=0 ;
    END ;

   sn_:=sn_+Dosn_ ;
   se_:=sn_ ;

   SELECT NVL(trim(txt),'9999') INTO nls1_
   FROM kl_f3_29
   WHERE kf='CC' and r020=nbs_;

   IF se_<>0 and ((nls1_<>'9999' and nls_=nls1_) or nls1_='9999') THEN
      kodp_:= '1' || nbs_ ;
      znap_:= TO_CHAR(ABS(se_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, Kv_, data_, kodp_, znap_);
   END IF;
END LOOP;
CLOSE SALDO;
-----------------------------------------------------------------------------
--- Остатки сформиров. по корр.проводкам для сч. отсутств. в конце месяца ---
OPEN Saldok;
   LOOP
   FETCH Saldok INTO acc_, nls_, kv_, data_, Nbs_, Dosn_ ; --- Dose_,Kose_
   EXIT WHEN Saldok%NOTFOUND;

   se_ := GL.P_ICURVAL(kv_, Dosn_, Dat_) ;

   SELECT NVL(trim(txt),'9999') INTO nls1_
   FROM kl_f3_29
   WHERE kf='CC' and r020=nbs_;

   IF se_<>0 and ((nls1_<>'9999' and nls_=nls1_) or nls1_='9999') THEN
      kodp_:= '1' || nbs_ ;
      znap_:= TO_CHAR(ABS(se_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, Kv_, data_, kodp_, znap_);
   END IF;
END LOOP;
CLOSE Saldok;
--------------------------------------------------------------------------
--- остатки по эквивалентам
OPEN SALDOQ;
LOOP
   FETCH SALDOQ INTO acc_, nls_, Kv_, data_, nbs_, sn_ ;
   EXIT WHEN SALDOQ%NOTFOUND;

--- отбор корректирующих проводок отчетного месяца
    BEGIN
       SELECT d.acc, NVL(SUM(DECODE(d.dk, 1, 1,-1)*d.s), 0)
       INTO acc3_, Dosn_
       FROM  kor_prov d
       WHERE d.acc=acc_                   AND
             d.fdat > Dat_                AND
             d.fdat <= Dat2_              AND
             d.vob = 96
       GROUP BY d.acc ;
    EXCEPTION WHEN NO_DATA_FOUND THEN
       Dosn_ :=0 ;
    END ;

   Dosek_:=GL.p_icurval(kv_, Dosn_, Dat_) ;
   sn_:=sn_+Dosek_ ;

   SELECT NVL(trim(txt),'9999') INTO nls1_
   FROM kl_f3_29
   WHERE kf='CC' and r020=nbs_;

   IF sn_<>0 and ((nls1_<>'9999' and nls_=nls1_) or nls1_='9999') THEN
      kodp_:= '1' || nbs_ ;
      znap_:= TO_CHAR(ABS(sn_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, Kv_, data_, kodp_, znap_);
   END IF;
END LOOP;
CLOSE SALDOQ;
-----------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_nbu where kodf='CC' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('CC', Dat_, kodp_, znap_); ---ROUND(to_number(znap_)/100,0));

---   itog_:=itog_+ROUND(to_number(znap_)/100,0);
   itog_:=itog_+to_number(znap_);

END LOOP;
CLOSE BaseL;

INSERT INTO tmp_nbu
    (kodf, datf, kodp, znap)
VALUES
    ('CC', Dat_, '10000', to_char(itog_));

znap_:=to_char(ROUND(itog_*0.00125,0));

INSERT INTO tmp_nbu
    (kodf, datf, kodp, znap)
VALUES
    ('CC', Dat_, '20000', znap_);

INSERT INTO tmp_nbu
    (kodf, datf, kodp, znap)
VALUES
    ('CC', Dat_, '30000', znap_);
----------------------------------------
END p_fCC;
/
show err;

PROMPT *** Create  grants  P_FCC ***
grant EXECUTE                                                                on P_FCC           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FCC.sql =========*** End *** ===
PROMPT ===================================================================================== 
