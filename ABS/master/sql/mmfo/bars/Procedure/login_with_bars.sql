

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/LOGIN_WITH_BARS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure LOGIN_WITH_BARS ***

  CREATE OR REPLACE PROCEDURE BARS.LOGIN_WITH_BARS 
is
begin
   bars.bars_login.login_user(null, null, null, null);
end;
/
show err;

PROMPT *** Create  grants  LOGIN_WITH_BARS ***
grant EXECUTE                                                                on LOGIN_WITH_BARS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/LOGIN_WITH_BARS.sql =========*** E
PROMPT ===================================================================================== 
