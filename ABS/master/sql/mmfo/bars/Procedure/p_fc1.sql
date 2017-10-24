

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FC1.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FC1 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FC1 (Dat_ DATE, code_f_ VARCHAR2 DEFAULT 'C1')  IS
---
acc_     NUMBER;
acc1_    NUMBER;
nls_     VARCHAR2(15);
Dat1_    DATE;
Dat2_    DATE;
Dat3_    DATE;
Dat4_    DATE;
Dat5_    DATE;
Dat6_    DATE;
data_    DATE;
kv_      SMALLINT;
sn_      DECIMAL(24);
Dosek_   DECIMAL(24);
Kosek_   DECIMAL(24);
Dose_    DECIMAL(24);
userid_  NUMBER;
nbs_     VARCHAR2(4);
kodp_    VARCHAR2(6);
znap_    VARCHAR2(30);
-------
datp_  	 DATE;
datpp_  	 DATE;
dt_form_ DATE;
dt_formp_ DATE;
dt_form28_ DATE;
--------
pr_year_ VARCHAR2(2);

--- остатки
CURSOR SALDOOG(a_dat_ IN DATE) IS
   SELECT a.acc, a.nls, a.kv, b.FDAT,
         Gl.P_Icurval(a.kv, b.ostf-b.dos+b.kos, a_dat_)
   FROM SALDOA b, ACCOUNTS a
   WHERE a.acc=b.acc                            AND
         a.nbs IN (SELECT DISTINCT r020 FROM KL_F3_29 WHERE kf=code_f_) AND
         (a.acc,b.FDAT) =
         (SELECT c.acc,MAX(c.FDAT)
          FROM SALDOA c
          WHERE a.acc=c.acc AND c.FDAT <= a_dat_
          GROUP BY c.acc) ;

---  орректирующие проводки дл€ счетов отсутствующих в конце мес€ца ---
CURSOR SALDOOGK(a_dat_b_ IN DATE,a_dat_e_ IN DATE) IS
   SELECT s.acc, s.nls, s.kv, s.daos, s.nbs,
          NVL(SUM(DECODE(a.DK, 1, 1, -1)*a.s), 0)
   FROM  KOR_PROV a, ACCOUNTS s
   WHERE s.nbs IN (SELECT DISTINCT r020 FROM KL_F3_29 WHERE kf=code_f_) AND
         a.FDAT > a_dat_b_                 AND
         a.FDAT <= a_dat_e_               AND
         a.acc=s.acc                   AND
         a.VOB=96                      AND
         s.daos > a_dat_b_
  GROUP BY s.acc, s.nls, s.kv, s.daos, s.nbs ;

--- остатки бал. счета 5040,5041
CURSOR SALDO5040(a_dat_ IN DATE) IS
   SELECT a.acc, a.nls, a.kv, b.FDAT,
          b.ostf-b.dos+b.kos
   FROM SALDOA b, ACCOUNTS a
   WHERE a.acc=b.acc                            AND
         (a.nbs='5040' OR a.nbs='5041')         AND
         (a.acc,b.FDAT) =
         (SELECT c.acc,MAX(c.FDAT)
          FROM SALDOA c
          WHERE a.acc=c.acc AND c.FDAT <= a_dat_
          GROUP BY c.acc) ;

--- остатки счетов технической переоценки
CURSOR SALDO3500(a_dat_ IN DATE) IS
   SELECT a.acc, a.nls, a.kv, b.FDAT,
          b.ostf-b.dos+b.kos
   FROM SALDOB b, ACCOUNTS a, TABVAL t
   WHERE a.acc=b.acc                            AND
         a.kv<>980                              AND
         a.kv=t.kv                              AND
         (a.nls=t.s0000 OR a.nls=t.s3800 OR a.nls=t.s3801)  AND
         a.nbs IN (SELECT DISTINCT r020 FROM KL_F3_29 WHERE kf=code_f_) AND
         (a.acc,b.FDAT) =
         (SELECT c.acc,MAX(c.FDAT)
          FROM SALDOB c
          WHERE a.acc=c.acc AND c.FDAT <= a_dat_
          GROUP BY c.acc) ;

---
CURSOR kl_F3(a_r020_ IN NUMBER) IS
	SELECT NVL(f.ddd,'000'), f.S240
	FROM KL_F3_29 f
	WHERE f.kf=code_f_ AND
		  f.r020=a_r020_;

---
CURSOR BaseL IS
   SELECT kodp, SUM(TO_NUMBER(znap))
   FROM RNBU_TRACE
   WHERE userid=userid_ AND
   		 (SUBSTR(kodp, 4, 1) IN ('1', '2')  AND
	     SUBSTR(kodp, 1, 3) <> '035') OR SUBSTR(kodp, 1, 3) = '035'
   GROUP BY kodp
   ORDER BY 1;
----------------------------------------------------------------------------
---------   формирование строки   --------------------------------------
PROCEDURE form_str(a_nls_ IN VARCHAR2,
		  		   a_kv_ IN SMALLINT,
				   a_data_ IN DATE,
		  		   a_sn_ IN DECIMAL,
				   a_year_ IN VARCHAR2,
				   a_tp_ IN BOOLEAN) IS
	kodp_    VARCHAR2(6);
	znap_    VARCHAR2(30);
	ddd_     VARCHAR(3);
	nbs_     VARCHAR2(4);
	zn_     VARCHAR2(1);
	snp_     DECIMAL;
 BEGIN
   nbs_:=SUBSTR(a_nls_,1,4);

   IF a_tp_ AND (nbs_='5040' OR nbs_='5041') THEN
   	  RETURN;
   END IF;

   IF a_sn_ <> 0 THEN
	   OPEN kl_F3(nbs_);
	   LOOP
		FETCH kl_F3 INTO ddd_,zn_;
		EXIT WHEN kl_F3%NOTFOUND;

		snp_ := a_sn_;

-- 		if zn_ is not null then
-- 		   if zn_='*' then
-- 			  snp_ := snp_ * (-1);
-- 			end if;
-- 		end if;

		kodp_:= RTRIM(ddd_) || a_year_ || '2' ;
		znap_:= TO_CHAR(a_sn_);

		INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap) VALUES
		                       (a_nls_, a_kv_, a_data_, kodp_, znap_);
	  END LOOP;
	  CLOSE kl_F3;
   END IF;
END form_str;
--------------   отбор корректирующих проводок  ---------------------------------------
PROCEDURE zap_kor_prov(a_d_beg_ IN DATE, a_d_end_ IN DATE) IS
BEGIN
	DELETE FROM KOR_PROV ;
	INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
	SELECT o.REF, o.DK, o.acc, o.s, o.FDAT, p.vdat, o.SOS, p.VOB
	FROM OPLDOK o, REF_KOR p
	WHERE o.FDAT>a_d_beg_     AND
	      o.FDAT<=a_d_end_    AND
	      o.REF=p.REF      AND
	      o.SOS=5 ;
END zap_kor_prov;
----------------------------------------------------------------------------
PROCEDURE ins_prot(a_p1_ IN VARCHAR2, a_p2_ IN VARCHAR2) IS
BEGIN
INSERT INTO RNBU_TRACE (RECID, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC)
SELECT recid, userid, nls, kv, odate,
	   SUBSTR(kodp,1,3)||a_p2_, TO_CHAR(TO_NUMBER(znap)*(-1)), nbuc
FROM RNBU_TRACE
WHERE userid=userid_ AND
   	  SUBSTR(kodp, 4, 1)=a_p1_ AND
	  SUBSTR(kodp, 1, 3) NOT IN ('035');
END ins_prot;
----------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM STAFF WHERE UPPER(logname)=UPPER(USER);
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
--поточний р≥к
Dat1_:= TRUNC(Dat_,'MM')-1;
Dat2_:= TRUNC(Dat_ + 28);

--попередн≥й р≥к
data_:=TRUNC(Dat_,'YEAR')-1;

SELECT MAX(FDAT) INTO datp_ FROM FDAT WHERE FDAT<=data_;

dat3_:=TRUNC(datp_,'MM')-1;
Dat4_:=TRUNC(datp_ + 28);

--попередн≥й дл€ попереднього р≥к
data_:=TRUNC(datp_,'YEAR')-1;

SELECT MAX(FDAT) INTO datpp_ FROM FDAT WHERE FDAT<=data_;

dat5_:=TRUNC(datpp_,'MM')-1;
Dat6_:=TRUNC(datpp_ + 28);

---------------------  орректирующие проводки ---------------------
DELETE FROM REF_KOR ;

IF TO_CHAR(Dat_,'MM')='12' THEN
   INSERT INTO REF_KOR (REF, VOB, VDAT)
   SELECT REF, VOB, vdat
   FROM OPER
   WHERE (VOB=96 OR VOB=99) AND TT NOT LIKE 'ZG%' AND
          NOT (((SUBSTR(nlsa,1,1)='6' OR SUBSTR(nlsa,1,1)='7')
          AND   (SUBSTR(nlsb,1,4)='5040' OR SUBSTR(nlsb,1,4)='5041')) OR
               ((SUBSTR(nlsa,1,4)='5040' OR SUBSTR(nlsa,1,4)='5041')
          AND   (SUBSTR(nlsb,1,1)='6' OR SUBSTR(nlsb,1,1)='7'))) ;
ELSE
   INSERT INTO REF_KOR (REF, VOB, VDAT)
   SELECT REF, VOB, vdat
   FROM OPER
   WHERE VOB=96 OR VOB=99 ;
END IF ;

FOR i IN 1..3 LOOP
	IF i=1 THEN --поточний р≥к
	   dt_form_:=dat_;
	   dt_formp_:=Dat1_;
	   dt_form28_:=Dat2_;
	   pr_year_:='10';
	ELSIF i=2 THEN  --попередн≥й р≥к
	   dt_form_:=datp_;
	   dt_formp_:=Dat3_;
	   dt_form28_:=Dat4_;
	   pr_year_:='20';
	ELSE  --попередн≥й р≥к
	   dt_form_:=datpp_;
	   dt_formp_:=Dat5_;
	   dt_form28_:=Dat6_;
	   pr_year_:='30';
	END IF;

	zap_kor_prov(dt_formp_,dt_form28_);
	-------------------------------------------------------------------
	--- остатки
	OPEN SALDOOG(dt_form_);
	LOOP
	   FETCH SALDOOG INTO acc_, nls_, kv_, data_, sn_;
	   EXIT WHEN SALDOOG%NOTFOUND;

	   --- отбор корректирующих проводок отчетного мес€ца
	   BEGIN
	      SELECT d.acc,
	         SUM(DECODE(d.DK, 0, Gl.P_Icurval(kv_, d.s, dt_form_), 0)),
	         SUM(DECODE(d.DK, 1, Gl.P_Icurval(kv_, d.s, dt_form_), 0))
	      INTO acc1_, Dosek_, Kosek_
	      FROM  KOR_PROV d
	      WHERE d.acc=acc_                   AND
	            d.FDAT > dt_form_                AND
	            d.FDAT <= dt_form28_              AND
	            d.VOB = 96
	      GROUP BY d.acc ;
	   EXCEPTION WHEN NO_DATA_FOUND THEN
	      Dosek_ :=0 ;
	      Kosek_ :=0 ;
	   END ;

	   sn_:=sn_-Dosek_+Kosek_;

	   BEGIN
	      SELECT NVL(SUM(p.s*DECODE(p.DK,0,-1,1,1,0)),0) INTO Dose_
	      FROM OPER o, OPLDOK p
	      WHERE o.REF  = p.REF  AND
	            p.FDAT = dt_form_   AND
	            o.SOS  = 5      AND
	            p.acc  = acc_   AND
	            o.TT  LIKE  'ZG%' ;
	   EXCEPTION WHEN NO_DATA_FOUND THEN
	      Dose_:=0;
	   END;

	   sn_:=sn_-Dose_;

	   form_str(nls_, kv_, data_,sn_,pr_year_,TRUE);
	END LOOP;
	CLOSE SALDOOG;
	-----------------------------------------------------------------------------
	--- ќстатки сформиров. по корр.проводкам дл€ сч. отсутств. в конце мес€ца ---
	OPEN SALDOOGK(dt_form_,dt_form28_);
	   LOOP
	   FETCH SALDOOGK INTO acc_, nls_, kv_, data_, Nbs_, Kosek_ ;
	   EXIT WHEN SALDOOGK%NOTFOUND;

	   Kosek_:=Gl.P_Icurval(kv_, Kosek_, dt_form_);

	   form_str(nls_, kv_, data_,Kosek_,pr_year_,TRUE);
	END LOOP;
	CLOSE SALDOOGK;
	--------------------------------------------------------------------------
	--- остатки бал. счета 5040, 5041
	OPEN SALDO5040(dt_form28_);
	LOOP
	   FETCH SALDO5040 INTO acc_, nls_, kv_, data_, sn_;
	   EXIT WHEN SALDO5040%NOTFOUND;

	   form_str(nls_, kv_, data_,sn_,pr_year_,FALSE);
	END LOOP;
	CLOSE SALDO5040;
	-----------------------------------------------------------------------------
	--- остатки счетов технической переоценки
	OPEN SALDO3500(dt_form_);
	LOOP
	   FETCH SALDO3500 INTO acc_, nls_, kv_, data_, sn_;
	   EXIT WHEN SALDO3500%NOTFOUND;

	   form_str(nls_, kv_, data_,sn_,pr_year_,FALSE);
	END LOOP;
	CLOSE SALDO3500;
END LOOP;
-----------------------------------------------------------------------------
ins_prot('2', '102');

ins_prot('3', '202');

INSERT INTO RNBU_TRACE
SELECT *
FROM RNBU_TRACE
WHERE SUBSTR(kodp, 1, 3) = '035';
-------------------------------------------------
DELETE FROM TMP_NBU WHERE kodf=code_f_ AND datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   IF SUBSTR(kodp_, 1, 3) = '035' THEN
   	  IF SUBSTR(kodp_, 4, 2) = '10' THEN
	  	 kodp_ := '036102';
	  ELSIF SUBSTR(kodp_, 4, 2) = '30' THEN
	  	 kodp_ := '035202';
	  ELSE
	  	 kodp_ := '035102';

	     INSERT INTO TMP_NBU (kodf, datf, kodp, znap)
	     VALUES (code_f_, Dat_, kodp_, znap_);

		 kodp_ := '036202';
	  END IF;
   END IF;

   INSERT INTO TMP_NBU
        (kodf, datf, kodp, znap)
   VALUES
        (code_f_, Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
END P_Fc1;
/
show err;

PROMPT *** Create  grants  P_FC1 ***
grant EXECUTE                                                                on P_FC1           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FC1           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FC1.sql =========*** End *** ===
PROMPT ===================================================================================== 
