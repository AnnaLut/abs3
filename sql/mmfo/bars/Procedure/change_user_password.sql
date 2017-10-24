

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CHANGE_USER_PASSWORD.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CHANGE_USER_PASSWORD ***

  CREATE OR REPLACE PROCEDURE BARS.CHANGE_USER_PASSWORD (
                                p_password in varchar2)
is
begin
    bars_useradm.change_user_password(user_id, p_password);
end change_user_password;
/
show err;

PROMPT *** Create  grants  CHANGE_USER_PASSWORD ***
grant EXECUTE                                                                on CHANGE_USER_PASSWORD to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CHANGE_USER_PASSWORD to BARS_CONNECT;
grant EXECUTE                                                                on CHANGE_USER_PASSWORD to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CHANGE_USER_PASSWORD.sql =========
PROMPT ===================================================================================== 
