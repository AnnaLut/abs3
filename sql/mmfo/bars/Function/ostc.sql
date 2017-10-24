
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/ostc.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.OSTC (nls_ VARCHAR2,kv_ SMALLINT, kf_ VARCHAR2 default '300465') RETURN NUMBER IS
ostc_   DECIMAL(24);
BEGIN
   SELECT ostc INTO ostc_ FROM accounts WHERE nls=nls_ AND kv=kv_ AND kf = kf_;
   RETURN ostc_;
EXCEPTION
   WHEN NO_DATA_FOUND THEN RETURN 0 ;
END OSTC;
/
 show err;
 
PROMPT *** Create  grants  OSTC ***
grant EXECUTE                                                                on OSTC            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OSTC            to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/ostc.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 