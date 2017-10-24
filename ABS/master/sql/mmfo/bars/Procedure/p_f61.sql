

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F61.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F61 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F61 (Dat_ DATE )  IS
nbs_     varchar2(4);
se_      DECIMAL(24);
kodp_    varchar2(10);
znap_    varchar2(30);
r013_    char(1);
ddd_     char(4);
-------------------------------------------------------------------
CURSOR SALDO IS
   SELECT a.nbs, nvl(cc.r013,'0'),
          to_char(SUM (gl.p_icurval(a.kv, a.ostf, Dat_)))
   FROM salotc a, customer c, cust_acc ca, cust cb,
        specparam cc, kl_f3_29 b
   WHERE a.nbs=b.r020            AND
         b.kf='61'               AND
         a.acc =ca.acc           AND
         c.rnk=ca.rnk            AND
         c.rnk=cb.rnk(+)         AND
         a.acc=cc.acc (+)        AND
         a.ostf <> 0             AND
         a.fdat = Dat_
   GROUP BY a.nbs, nvl(cc.r013,'0');
BEGIN
DELETE FROM tmp_nbu where kodf='61' and datf= dat_;
OPEN SALDO;
LOOP
   FETCH SALDO INTO nbs_, r013_, se_ ;
   EXIT WHEN SALDO%NOTFOUND;
   IF SE_<>0 THEN
      BEGIN
         SELECT r020 INTO ddd_ FROM kl_f3_29
         WHERE kf='61' AND r020=nbs_ ;
         EXCEPTION
         WHEN NO_DATA_FOUND THEN
         ddd_ := NULL;
      END;
      IF ddd_ IS NOT NULL THEN
         kodp_:= nbs_ || r013_ ;
         znap_:= ABS(se_) || '' ;
         INSERT INTO tmp_nbu (kodf, datf, kodp, znap) VALUES
                             ('61', Dat_, kodp_,znap_);
      END IF;
   END IF;
END LOOP;
CLOSE SALDO;
INSERT INTO tmp_nbu (kodf, datf, kodp, znap)
 values ('61', Dat_, '98350', '0');
----------------------------------------
END p_f61;
/
show err;

PROMPT *** Create  grants  P_F61 ***
grant EXECUTE                                                                on P_F61           to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F61.sql =========*** End *** ===
PROMPT ===================================================================================== 
