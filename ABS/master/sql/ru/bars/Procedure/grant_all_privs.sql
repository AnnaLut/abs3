

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GRANT_ALL_PRIVS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GRANT_ALL_PRIVS ***

  CREATE OR REPLACE PROCEDURE BARS.GRANT_ALL_PRIVS (CODEAPP_ CHAR DEFAULT NULL) IS
BEGIN
  abs_utils.grant_func_privs(CODEAPP_);
  abs_utils.grant_ref_privs(CODEAPP_);
END;
/
show err;

PROMPT *** Create  grants  GRANT_ALL_PRIVS ***
grant EXECUTE                                                                on GRANT_ALL_PRIVS to ABS_ADMIN;
grant EXECUTE                                                                on GRANT_ALL_PRIVS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GRANT_ALL_PRIVS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GRANT_ALL_PRIVS.sql =========*** E
PROMPT ===================================================================================== 
