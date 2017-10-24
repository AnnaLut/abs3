

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/VERIFY_ACC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure VERIFY_ACC ***

  CREATE OR REPLACE PROCEDURE BARS.VERIFY_ACC (nls_ IN  VARCHAR2,
                                        kv_  IN  NUMBER,
                                        acc_ OUT NUMBER) IS

-- Ver @(#) verify_acc.sql 3.1.1.1 98/08/28

ern       CONSTANT POSITIVE := 222;  -- Cannot obtain verify_acc

BEGIN
  SELECT acc INTO acc_ FROM accounts WHERE nls_=NLS AND kv_=KV;
EXCEPTION
  WHEN NO_DATA_FOUND THEN acc_ := -1;
  WHEN OTHERS THEN
    raise_application_error(-(20000+ern),SQLERRM,TRUE);

end verify_acc;
 
/
show err;

PROMPT *** Create  grants  VERIFY_ACC ***
grant EXECUTE                                                                on VERIFY_ACC      to ABS_ADMIN;
grant EXECUTE                                                                on VERIFY_ACC      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on VERIFY_ACC      to TECH_MOM1;
grant EXECUTE                                                                on VERIFY_ACC      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/VERIFY_ACC.sql =========*** End **
PROMPT ===================================================================================== 
