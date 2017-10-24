

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F83.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F83 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F83 (Dat_ DATE )  IS  --( _sDate VARCHAR(10))

nbs_     varchar2(4);
nls_     varchar2(15);
data_    date;
kv_      SMALLINT;
Se_      DECIMAL(24);
Sn_      DECIMAL(24);
kodp_    varchar2(10);
znap_    varchar2(30);
daos_    date;
mdate_   date;
na_      number;
userid_  Number;

--Остатки, обороты
CURSOR SALDO IS
   SELECT s.nls, a.kv, a.fdat, s.daos, s.mdate, a.ostf,
          GL.P_ICURVAL(a.kv, a.ostf-a.dos+a.kos, Dat_)
   FROM (SELECT aa.acc, s.kv, aa.fdat, s.nbs, aa.ostf, aa.dos, aa.kos
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc      AND
              (s.acc,aa.fdat) =
               (select c.acc,max(c.fdat)
                from saldoa c
                where s.acc=c.acc and c.fdat <= Dat_
                group by c.acc)  AND
                aa.ostf-aa.dos+aa.kos <> 0) a,
         accounts s
   WHERE a.nbs='1212'           AND
         a.kv <> 980            AND
         a.acc = s.acc ;

CURSOR BaseL IS
    SELECT kodp, SUM (znap)
    FROM rnbu_trace
    WHERE userid=userid_
    GROUP BY kodp
    ORDER BY kodp;

/*l_BaseL       BaseL%rowtype;*/

BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
na_:=1 ;

OPEN SALDO;
LOOP
   FETCH SALDO INTO nls_, kv_, data_, daos_, mdate_, Sn_, Se_ ;
   EXIT WHEN SALDO%NOTFOUND;
   IF Sn_<>0 THEN
      kodp_:= '02' || SUBSTR(TO_CHAR(100000+na_),2,5) ||
                      SUBSTR(TO_CHAR(1000+kv_),2,3) ;
      znap_:= SUBSTR(TO_CHAR(100000+na_),2,5) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                        (nls_, kv_, data_, kodp_, znap_) ;

      kodp_:= '03' || SUBSTR(TO_CHAR(100000+na_),2,5) ||
                      SUBSTR(TO_CHAR(1000+kv_),2,3) ;
      znap_:= TO_CHAR(daos_,'DDMMYYYY') ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                        (nls_, kv_, data_, kodp_, znap_) ;

      kodp_:= '04' || SUBSTR(TO_CHAR(100000+na_),2,5) ||
                      SUBSTR(TO_CHAR(1000+kv_),2,3) ;
      znap_:= TO_CHAR(mdate_,'DDMMYYYY') ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                        (nls_, kv_, data_, kodp_, znap_) ;

      kodp_:= '07' || SUBSTR(TO_CHAR(100000+na_),2,5) ||
                      SUBSTR(TO_CHAR(1000+kv_),2,3) ;
      znap_:= TO_CHAR(ABS(Se_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                        (nls_, kv_, data_, kodp_, znap_);

      kodp_:= '08' || SUBSTR(TO_CHAR(100000+na_),2,5) ||
                      SUBSTR(TO_CHAR(1000+kv_),2,3) ;
      znap_:= TO_CHAR(ABS(Sn_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_,znap_);
   END IF;
   na_:= na_+1 ;
END LOOP;
CLOSE SALDO;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf='83' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('83', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
-------------------------------------------------
END p_f83;
/
show err;

PROMPT *** Create  grants  P_F83 ***
grant EXECUTE                                                                on P_F83           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F83           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F83.sql =========*** End *** ===
PROMPT ===================================================================================== 
