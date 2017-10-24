

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZAYDEBT_IMP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZAYDEBT_IMP ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZAYDEBT_IMP ( dat_ DATE )
IS
  ref_   int;
BEGIN
 FOR a IN
       (SELECT acc FROM accounts
        WHERE nls LIKE '2603%' AND (dazs IS NULL OR dazs>=dat_)) LOOP
    FOR o IN
          (SELECT o.ref FROM opldok o, oper p
           WHERE o.acc=a.acc AND o.ref=p.ref AND o.tt=p.tt AND
                 o.fdat=dat_ AND o.dk=1      AND o.sos=5       ) LOOP
             BEGIN
               SELECT ref INTO ref_ FROM zay_debt
               WHERE ref=o.ref AND refd IS NULL;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  INSERT INTO zay_debt (ref, refd, sos, tip)
                  VALUES (o.ref, null, 0, 2);
             END;
    END LOOP;
 END LOOP;
END p_zaydebt_imp;
/
show err;

PROMPT *** Create  grants  P_ZAYDEBT_IMP ***
grant EXECUTE                                                                on P_ZAYDEBT_IMP   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ZAYDEBT_IMP   to WR_ALL_RIGHTS;
grant EXECUTE                                                                on P_ZAYDEBT_IMP   to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZAYDEBT_IMP.sql =========*** End
PROMPT ===================================================================================== 
