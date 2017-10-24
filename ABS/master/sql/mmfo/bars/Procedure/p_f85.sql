

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F85.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F85 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F85 (Dat_ DATE )  IS
sDos_   Number(24);
sKos_   Number(24);
sPCnt_  Number;
sPCnt1_ Varchar2(10);
Kv_     SMALLINT;
Nbs_    char(4);
Cntr_   Number;
cust_   SMALLINT;
rnk_    Number;
f03k_   Number;
f03d_   Number;
S180_   char(1);
k081_   char(1);
k092_   char(1);
ddd_    char(3);
nls_    varchar2(15);
data_   date;
kodp1_  varchar2(35);
kodp2_  varchar2(35);
Sob_    Number;
SobPr_  Number;
userid_ Number;

CURSOR Saldo IS
    SELECT s.nls, s.kv, a.fdat, s.nbs, k.ddd,
           DECODE(k.s240, ' ',
                               DECODE(p.s180, NULL, FS180(a.acc),
                                              ' ' , FS180(a.acc), p.s180),
		         NULL, DECODE(p.s180, NULL, FS180(a.acc),
                                              ' ' , Fs180(a.acc), p.s180),
		  k.s240),
           c.rnk, MOD(c.codcagent, 2),
           GL.P_ICURVAL(s.kv,a.dos,Dat_),
           GL.P_ICURVAL(s.kv,a.kos,Dat_),
           acrn.FPROC(a.acc, Dat_)
    FROM accounts s, saldoa a, customer c,
         cust_acc ca, kl_f3_29 k, specparam p
    WHERE s.nbs=k.r020                AND
          k.kf='85'                   AND
          s.kv=980                    AND
          s.acc=a.acc                 AND
          s.acc=ca.acc                AND
          s.acc=p.acc(+)              AND
          ca.rnk=c.rnk                AND
          a.fdat = Dat_;

CURSOR BaseL IS
    SELECT a.kodp, b.kodp, SUM(TO_NUMBER(a.znap)),
           SUM(TO_NUMBER(a.znap)*TO_NUMBER(b.znap))
    FROM rnbu_trace a, rnbu_trace b
    WHERE SUBSTR(a.kodp,2)=SUBSTR(b.kodp,2) AND
          SUBSTR(a.kodp,1,1)='1'            AND
          SUBSTR(b.kodp,1,1)='2'            AND
          a.nls = b.nls                     AND
          TO_NUMBER(b.znap)<>0              AND
          a.userid = userid_                AND
          b.userid = userid_
    GROUP BY a.kodp, b.kodp
    ORDER BY a.kodp;

BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
---DELETE FROM RNBU_HISTORY WHERE odate = Dat_;

OPEN Saldo;
LOOP
    FETCH Saldo INTO nls_, Kv_, data_, nbs_, ddd_, S180_,
                     rnk_, Cntr_, sDos_, sKos_, sPCnt_;
    EXIT WHEN Saldo%NOTFOUND;
    f03k_ := 0 ;
    f03d_ := 0 ;

    IF nbs_='2620' OR nbs_='2625' THEN
       s180_:='1';
    END IF;

    IF nbs_='1510' OR nbs_='1521' OR nbs_='1610' OR nbs_='1621' THEN
       s180_:='2';
    END IF;

    IF sDos_ > 0 AND sPCnt_ <> 0 THEN
       SELECT count(*) INTO f03k_
       FROM kl_f3_29
       WHERE kf='85'   AND
             r020=nbs_ AND
             r050='11' ;

       IF f03k_>0 THEN
          INSERT INTO rnbu_trace         -- Дб. обороты
                  (nls, kv, odate, kodp, znap)
          VALUES  (nls_, Kv_, Dat_, '1' || ddd_ || S180_ ||
                      SUBSTR( to_char(1000+Kv_), 2, 3) || to_char(2-Cntr_),
                      TO_CHAR(sDos_));

          INSERT INTO rnbu_trace         -- %% ставка
                  (nls, kv, odate, kodp, znap)
          VALUES  (nls_, Kv_, Dat_, '2' || ddd_ || S180_ ||
                     SUBSTR( to_char(1000+Kv_), 2, 3)  || to_char(2-Cntr_),
                     LTRIM(TO_CHAR(ROUND(sPCnt_,4),'999D9999')));
       END IF;
    END IF;

    IF sKos_ > 0 AND sPCnt_ <> 0 THEN
       SELECT count(*) INTO f03d_
       FROM kl_f3_29
       WHERE kf='85'   AND
             r020=nbs_ AND
             r050='22' ;

       IF f03d_>0 THEN
          INSERT INTO rnbu_trace         -- Кр. обороты
                 (nls, kv, odate, kodp, znap)
          VALUES (nls_, Kv_, Dat_, '1' || ddd_ || S180_ ||
                  SUBSTR( to_char(1000+Kv_), 2, 3) || to_char(2-Cntr_),
                  TO_CHAR(sKos_) );
          INSERT INTO rnbu_trace         -- %% ставка
                 (nls, kv, odate, kodp, znap)
          VALUES (nls_, Kv_, Dat_, '2' || ddd_ || S180_ ||
                  SUBSTR( to_char(1000+Kv_), 2, 3) || to_char(2-Cntr_),
                  LTRIM(TO_CHAR(ROUND(sPCnt_,4),'999D9999')));
       END IF;
    END IF;
END LOOP;
CLOSE Saldo;
---------------------------------------------------
DELETE FROM tmp_nbu WHERE kodf='85' AND datf= Dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO kodp1_, kodp2_, Sob_, SobPr_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('85', Dat_, kodp1_, TO_CHAR(Sob_));

   IF ROUND(SobPr_/Sob_,4) < 1 THEN
      sPCnt1_:= LTRIM(TO_CHAR(ROUND(SobPr_/Sob_,4),'0D9999'));
   ELSE
      sPCnt1_:= LTRIM(TO_CHAR(ROUND(SobPr_/Sob_,4),'999D9999'));
   END IF ;

   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('85', Dat_, kodp2_, sPCnt1_);
---LTRIM(TO_CHAR(ROUND(SobPr_/Sob_,4),'999D9999')));
END LOOP;
CLOSE BaseL;
----------------------------------------------------------------------
END P_F85;
/
show err;

PROMPT *** Create  grants  P_F85 ***
grant EXECUTE                                                                on P_F85           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F85           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F85.sql =========*** End *** ===
PROMPT ===================================================================================== 
