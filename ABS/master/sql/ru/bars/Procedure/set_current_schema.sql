

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SET_CURRENT_SCHEMA.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SET_CURRENT_SCHEMA ***

  CREATE OR REPLACE PROCEDURE BARS.SET_CURRENT_SCHEMA (
                                p_cschema  in  varchar2 )
is
begin
    bars_login.change_user_appschema(p_cschema);
end set_current_schema;
/
show err;

PROMPT *** Create  grants  SET_CURRENT_SCHEMA ***
grant EXECUTE                                                                on SET_CURRENT_SCHEMA to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SET_CURRENT_SCHEMA to BARS_CONNECT;
grant EXECUTE                                                                on SET_CURRENT_SCHEMA to START1;
grant EXECUTE                                                                on SET_CURRENT_SCHEMA to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SET_CURRENT_SCHEMA.sql =========**
PROMPT ===================================================================================== 
