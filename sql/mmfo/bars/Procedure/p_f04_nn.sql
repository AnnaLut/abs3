

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F04_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F04_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F04_NN (Dat_ DATE ,
                                      sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #04
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 12.12.2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
30.12.2005 включаются счета овердрафтов "8025"
31.01.2006 включались не только овердрафты, а и пасс.остатки для 2620,2625
           добавил условие sDos_=0 и sKos_=0
24.02.2006 вместо кода K081 (форма собственности 1 уровня) будет "0"
29.09.2006 - формируем в RNBU_TRACE вместо 2-х строк код "1"-сумма и
             код "2"-процентная ставка ТРИ строки код "1"-сумма,
             код "2"-процентная ставка и код "3"-сумма*процентную ставку
             Формирование показателей в TMP_NBU производим по кодом "1" и
             "3", а затем код "3" из RNBU_TRACE удаляем.
12.12.2006 - будут формироваться показатели для пролонгированных счетов
             т.е. была изменена дата погашения остатка и %% ставка без
             движения по счету (в RNBU_HISTORY dos=0, kos=0, ost<>0).
             Ранее включались по условию dos=0,kos=0,ost<>0 только счета
             овердрафтов.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='04';
typ_ 	 number;
fmt_     varchar2(20):='990D0000';

nls_     varchar2(15);
data_    date;
dat1_    date;
dat2_    date;
acc_     number;
sDos_    number;
sKos_    number;
se_      number;
sPCnt_   number;
sPCnt1_  varchar2(20);
Kv_      number;
Nbs_     varchar2(4);
Cntr_    number;
Cntr1_   varchar2(1);
rnk_     number;
mfo_     number;
mfo1_    Varchar2(12);
f04_     number;
f04d_    number;
f04k_    number;
kolvo_   number;
K112_    char(1);
K081_    char(1);
K071_    varchar2(1);
mb_      varchar2(1);
d020_    varchar2(1);
S180_    char(1);
ddd_     char(3);
kodp_    varchar2(12);
kodp2_   varchar2(35);
Sob_     number;
SobPr_   number;
userid_  number;
nbuc1_   varchar2(12);
nbuc_    varchar2(12);
sql_     VARCHAR2 (200);

CURSOR SaldoAOd IS
    SELECT c.acc,a.nls, a.kv, a.codcagent, a.odate, a.s180, a.k081, a.k112,
           NVL(a.mb,'9'), NVL(to_char(to_number(a.d020)),'X'), a.ints,
           k.ddd, a.dos, a.kos, a.ost
    FROM rnbu_history a, kl_f3_29 k,accounts c
    WHERE substr(a.nls,1,4)=k.r020
	 AND a.nls=c.nls
	 AND a.kv =c.kv
	 AND  k.kf=kodf_
	 AND  (a.dos+a.kos <> 0  OR   a.ost<>0)
	 AND  a.ints>=0
	 AND  a.odate > DAT1_
	 AND  a.odate <= Dat_ ;

CURSOR SaldoKor IS
    SELECT s.acc, s.nls, s.kv, a.fdat, s.nbs, k.ddd,
           DECODE(k.s240, ' ',
                               DECODE(p.s180, NULL, FS180(a.acc),
                                              ' ' , FS180(a.acc), p.s180),
		         NULL, DECODE(p.s180, NULL, FS180(a.acc),
                                              ' ' , Fs180(a.acc), p.s180),
		  k.s240),
           MOD(c.codcagent, 2), c.rnk, NVL(to_char(to_number(p.d020)),'1'),
           SUM(DECODE(a.dk, 0, GL.P_ICURVAL(s.kv, a.s, a.fdat), 0)),
           SUM(DECODE(a.dk, 1, GL.P_ICURVAL(s.kv, a.s, a.fdat), 0))
    FROM kor_prov a, accounts s, customer c,
         cust_acc ca, specparam p, kl_f3_29 k
    WHERE substr(s.nls,1,4)=k.r020  AND
          k.kf=kodf_                AND
          a.s <> 0                  AND
          a.fdat > Dat_             AND
          a.fdat <= Dat2_           AND
          s.acc=a.acc               AND
          s.acc=ca.acc              AND
          s.acc=p.acc(+)            AND
          ca.rnk=c.rnk
    GROUP BY s.acc, s.nls, s.kv, a.fdat, s.nbs, k.ddd,
            DECODE(k.s240, ' ',
                               DECODE(p.s180, NULL, FS180(a.acc),
                                              ' ' , FS180(a.acc), p.s180),
		         NULL, DECODE(p.s180, NULL, FS180(a.acc),
                                              ' ' , Fs180(a.acc), p.s180),
		  k.s240),
           MOD(c.codcagent, 2), c.rnk, NVL(to_char(to_number(p.d020)),'1');

--CURSOR BaseL IS
--    SELECT a.kodp, b.kodp, a.nbuc,
--    	   SUM(TO_NUMBER(a.znap)),
--    	   SUM(TO_NUMBER(a.znap)*TO_NUMBER(b.znap)), count(*)
--    FROM rnbu_trace a, rnbu_trace b
--    WHERE SUBSTR(a.kodp,2)=SUBSTR(b.kodp,2)
--	 AND  SUBSTR(a.kodp,1,1)='1'
--	 AND  SUBSTR(b.kodp,1,1)='2'
--	 AND  a.nls = b.nls
--	 AND  a.odate=b.odate
--	 AND  TO_NUMBER(b.znap)>=0
--	 AND  a.userid = userid_
--	 AND  b.userid = userid_
--	 AND  a.NBUC   = b.NBUC
--    GROUP BY a.kodp, b.kodp, a.nbuc
--    ORDER BY a.kodp;

   CURSOR Basel IS
      SELECT nbuc, kodp, SUM (TO_NUMBER (znap)),
               SUM (TO_NUMBER (znap_pr)), count(*)
      FROM (SELECT a.nbuc NBUC, a.kodp KODP, a.znap ZNAP, '0' ZNAP_PR
            FROM RNBU_TRACE a
            WHERE SUBSTR (a.kodp, 1, 1) = '1'
            UNION ALL
            SELECT a.nbuc NBUC, '1'||substr(a.kodp,2,11) KODP, '0' ZNAP,
                   a.znap ZNAP_PR
            FROM RNBU_TRACE a
            WHERE SUBSTR (a.kodp, 1, 1) = '3')
      GROUP BY nbuc, kodp
      ORDER BY nbuc, kodp;

BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_ - TO_NUMBER(TO_CHAR(Dat_,'DD')));
Dat2_ := TRUNC(Dat_ + 28);

p_proc_set(kodf_,sheme_,nbuc1_,typ_);

p_populate_kor(Dat1_,Dat2_,'');
-------------------------------------------------------------------
mfo_:=F_OURMFO();

OPEN SaldoAOd;
LOOP
    FETCH SaldoAOd INTO acc_,nls_, Kv_, Cntr_, data_, S180_, K081_, K112_, MB_,
                        d020_, sPCnt_, ddd_, sDos_, sKos_, se_ ;
    EXIT WHEN SaldoAOd%NOTFOUND;

	if typ_>0 then
	   nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
	else
	   nbuc_ := nbuc1_;
	end if;

    IF mb_='0' THEN
       mb_:='9';
    END IF;

    nbs_:=substr(nls_,1,4);

    IF nbs_ not in ('2600','2605','2620','2625','2650','2655','8025') AND
       sDos_>0 AND sPCnt_>=0 THEN

      SELECT count(*) INTO f04_ FROM kl_f3_29 WHERE kf=kodf_ AND
             nbs_=r020 AND r050='11';

       if f04_>0 THEN
          IF to_number(ddd_) < 701 THEN
             k112_:='0';
             k081_:='0';
          END IF ;

          K081_:='0';  -- с 01.03.2006

          INSERT INTO rnbu_trace
                  (nls, kv, odate, kodp, znap, nbuc)
          VALUES  (nls_, kv_, data_, '1' || ddd_ || K112_ || K081_ ||
                         MB_ || SUBSTR(to_char(1000+Kv_),2,3) ||
                         to_char(2-Cntr_) || d020_, TO_CHAR(sDos_),nbuc_);

          sPCnt1_:= LTRIM(TO_CHAR(ROUND(sPCnt_,4),fmt_));

          INSERT INTO rnbu_trace
                  (nls, kv, odate, kodp, znap,nbuc)
          VALUES  (nls_, kv_, data_, '2' || ddd_ || K112_ || K081_ ||
                         MB_ || SUBSTR(to_char(1000+Kv_),2,3) ||
                         to_char(2-Cntr_) || d020_, sPCnt1_,nbuc_);

          INSERT INTO rnbu_trace
                  (nls, kv, odate, kodp, znap, nbuc)
          VALUES  (nls_, kv_, data_, '3' || ddd_ || K112_ || K081_ ||
                         MB_ || SUBSTR(to_char(1000+Kv_),2,3) ||
                         to_char(2-Cntr_) || d020_,
                         to_char(sDos_*to_number(sPCnt1_)),nbuc_);

       END IF;
    END IF;

    IF nbs_ not in ('2600','2605','2650','2655','8025') AND
       sKos_>0 AND sPCnt_>=0 THEN
       SELECT count(*) INTO f04_ FROM kl_f3_29 WHERE kf=kodf_ AND
              nbs_=r020  AND r050='22';

       if f04_>0 THEN

          IF to_number(ddd_) < 701 THEN
             k112_:='0';
             k081_:='0';
          END IF ;

          K081_:='0';  -- с 01.03.2006

          INSERT INTO rnbu_trace
                  (nls, kv, odate, kodp, znap, nbuc)
          VALUES  (nls_, kv_, data_, '1' || ddd_ || K112_ || K081_ ||
                         MB_ || SUBSTR(to_char(1000+Kv_),2,3) ||
                         to_char(2-Cntr_) || d020_, TO_CHAR(sKos_),nbuc_);

          sPCnt1_:= LTRIM(TO_CHAR(ROUND(sPCnt_,4),fmt_));

          INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
          VALUES  (nls_, kv_, data_, '2' || ddd_ || K112_ || K081_ || MB_ ||
                   SUBSTR(to_char(1000+Kv_),2,3) || to_char(2-Cntr_) || d020_,
                   sPCnt1_,nbuc_);

          INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
          VALUES  (nls_, kv_, data_, '3' || ddd_ || K112_ || K081_ || MB_ ||
                   SUBSTR(to_char(1000+Kv_),2,3) || to_char(2-Cntr_) || d020_,
                   to_char(sKos_*to_number(sPCnt1_)), nbuc_);

       END IF;
    END IF;

--    IF nbs_ in ('2600','2605','2620','2625','2650','2655','8025') AND
--       sDos_=0 and sKos_=0 and se_<>0 AND sPCnt_>=0 THEN

    IF sDos_=0 and sKos_=0 and se_<>0 AND sPCnt_>=0 THEN
       SELECT count(*) INTO f04_ FROM kl_f3_29 WHERE kf=kodf_ AND
              nbs_=r020  AND r050='11';

       if f04_>0 THEN

          IF to_number(ddd_) < 701 THEN
             k112_:='0';
             k081_:='0';
          END IF ;

          K081_:='0';  -- с 01.03.2006

          --- проверяем признак консолидированного счета 2625 для 8025
          sql_ :=
                'BEGIN '
             || '  SELECT count(*) '
             || '  INTO :d '
             || '  FROM NSMEP_SPARAMS '
             || '  WHERE bal_nls=:p ; '
             || 'EXCEPTION WHEN NO_DATA_FOUND THEN '
             || '		  :d := 0; '
             || 'END;';

          if mfo_=353575 and nbs_='2625' then
             EXECUTE IMMEDIATE sql_
                      USING OUT kolvo_, IN nls_;
          end if;

          IF (mfo_=353575 and nbs_='2625' and kolvo_=0) OR
              (mfo_=353575 and nbs_<>'2625') OR mfo_<>353575  THEN

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
             VALUES  (nls_, kv_, data_, '1' || ddd_ || K112_ || K081_ || MB_ ||
                      SUBSTR(to_char(1000+Kv_),2,3) || to_char(2-Cntr_) || d020_,
                      TO_CHAR(Abs(se_)),nbuc_);

             sPCnt1_:= LTRIM(TO_CHAR(ROUND(sPCnt_,4),fmt_));

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
             VALUES  (nls_, kv_, data_, '2' || ddd_ || K112_ || K081_ || MB_ ||
	              SUBSTR(to_char(1000+Kv_),2,3) || to_char(2-Cntr_) || d020_,
                      sPCnt1_,nbuc_);

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
             VALUES  (nls_, kv_, data_, '3' || ddd_ || K112_ || K081_ || MB_ ||
	              SUBSTR(to_char(1000+Kv_),2,3) || to_char(2-Cntr_) || d020_,
                      to_char(ABS(se_)*to_number(sPCnt1_)), nbuc_);
          END IF;
       END IF;
    END IF;
END LOOP;
CLOSE SaldoAOd;
---------------------------------------------------------------------
OPEN SaldoKor;
LOOP
    FETCH SaldoKor INTO acc_, nls_, Kv_, data_, nbs_, ddd_, S180_, Cntr_,
                     rnk_, d020_, sDos_, sKos_;
    EXIT WHEN SaldoKor%NOTFOUND;

    f04k_ := 0 ;
    f04d_ := 0 ;

	if typ_>0 then
	   nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
	else
	   nbuc_ := nbuc1_;
	end if;

    SELECT nvl(d.k112,'0'), nvl(f.k081,'0'), nvl(e.k071,'0'), nvl(b.mb,'9')
    INTO k112_, k081_, k071_, mb_
    FROM  customer b, kl_k110 d, kl_k080 f, kl_k070 e
    WHERE b.rnk=rnk_       AND
          b.ved=d.k110(+)  AND
          b.fs=f.k080(+)   AND
          b.ise=e.k070(+);

    IF k071_='4' THEN
      mb_:='1';
    END IF;

    sPCnt_:=acrn.FPROC(acc_, data_) ;

    IF nbs_ not in ('2600','2605','2620','2625','2650','2655') AND sDos_>0 AND
       sPCnt_ >=0 THEN

       SELECT count(*) INTO f04k_ FROM kl_f3_29 WHERE kf=kodf_ AND
              r020=nbs_ AND r050='11' ;

       IF f04k_>0 THEN

          Cntr1_:= to_char(2-Cntr_) ;

          IF to_number(ddd_) < 701 THEN
             k112_:='0';
             k081_:='0';
          END IF ;

          K081_:='0';  -- с 01.03.2006

          INSERT INTO rnbu_trace
                  (nls, kv, odate, kodp, znap, nbuc)
          VALUES  (nls_, Kv_, Dat_, '1' || ddd_ || K112_ || K081_ || MB_ ||
                   SUBSTR( to_char(1000+Kv_),2,3) || Cntr1_ || d020_,
                   TO_CHAR(sDos_), nbuc_);

          sPCnt1_ := LTRIM(TO_CHAR(ROUND(sPCnt_,4),fmt_));

          INSERT INTO rnbu_trace
                  (nls, kv, odate, kodp, znap, nbuc)
          VALUES  (nls_, Kv_, Dat_, '2' || ddd_ || K112_ || K081_ || MB_ ||
                   SUBSTR(to_char(1000+Kv_),2,3)  || Cntr1_ || d020_,
                   sPCnt1_, nbuc_) ;

          INSERT INTO rnbu_trace
                  (nls, kv, odate, kodp, znap, nbuc)
          VALUES  (nls_, Kv_, Dat_, '3' || ddd_ || K112_ || K081_ || MB_ ||
                   SUBSTR(to_char(1000+Kv_),2,3)  || Cntr1_ || d020_,
                   to_char(sDos_*to_number(sPCnt1_)), nbuc_) ;

       END IF;
    END IF;

    IF nbs_ not in ('2600','2605','2650','2655') AND sKos_>0 AND sPCnt_>=0 THEN

       SELECT count(*) INTO f04d_ FROM kl_f3_29 WHERE kf=kodf_ AND
             r020=nbs_ AND r050='22' ;

       IF f04d_>0 THEN
          Cntr1_:= to_char(2-Cntr_) ;

          IF to_number(ddd_) < 701 THEN
             k112_:='0';
             k081_:='0';
          END IF ;

          K081_:='0';  -- с 01.03.2006

          INSERT INTO rnbu_trace
                 (nls, kv, odate, kodp, znap, nbuc)
          VALUES (nls_, Kv_, Dat_, '1' || ddd_ || K112_ || K081_ || MB_ ||
                  SUBSTR(to_char(1000+Kv_),2,3) || Cntr1_ || d020_,
                  TO_CHAR(sKos_), nbuc_);

          sPCnt1_ := LTRIM(TO_CHAR(ROUND(sPCnt_,4),fmt_));

          INSERT INTO rnbu_trace
                 (nls, kv, odate, kodp, znap, nbuc)
          VALUES (nls_, Kv_, Dat_, '2' || ddd_ || K112_ || K081_ || MB_ ||
                  SUBSTR(to_char(1000+Kv_),2,3) || Cntr1_ || d020_,
                  sPCnt1_, nbuc_) ;

          INSERT INTO rnbu_trace
                 (nls, kv, odate, kodp, znap, nbuc)
          VALUES (nls_, Kv_, Dat_, '3' || ddd_ || K112_ || K081_ || MB_ ||
                  SUBSTR(to_char(1000+Kv_),2,3) || Cntr1_ || d020_,
                  to_char(sKos_*to_number(sPCnt1_)), nbuc_) ;

       END IF;
    END IF;

END LOOP;
CLOSE SaldoKor;
---------------------------------------------------
DELETE FROM tmp_nbu WHERE kodf=kodf_ AND datf= Dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO nbuc_, kodp_, Sob_, SobPr_, f04_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu  (kodf, datf, kodp, znap, nbuc) VALUES
                        (kodf_, Dat_, kodp_, TO_CHAR(Sob_), nbuc_);

   sPCnt1_:= LTRIM(TO_CHAR(ROUND(SobPr_/Sob_,4),fmt_));

   INSERT INTO tmp_nbu (kodf, datf, kodp, znap, nbuc) VALUES
                      (kodf_, Dat_, '2'||substr(kodp_,2,11), sPCnt1_, nbuc_);

END LOOP;
CLOSE BaseL;

DELETE FROM RNBU_TRACE
   WHERE userid = userid_ AND
         kodp like '3%';

----------------------------------------------------------------------
END P_F04_NN;
 
/
show err;

PROMPT *** Create  grants  P_F04_NN ***
grant EXECUTE                                                                on P_F04_NN        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F04_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
