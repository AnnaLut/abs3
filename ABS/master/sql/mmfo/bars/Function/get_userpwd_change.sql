
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_userpwd_change.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_USERPWD_CHANGE return char
is
begin
    return bars_useradm.get_userpwd_change(user_id);
end;
/
 show err;
 
PROMPT *** Create  grants  GET_USERPWD_CHANGE ***
grant EXECUTE                                                                on GET_USERPWD_CHANGE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_USERPWD_CHANGE to BARS_CONNECT;
grant EXECUTE                                                                on GET_USERPWD_CHANGE to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_userpwd_change.sql =========***
 PROMPT ===================================================================================== 
 