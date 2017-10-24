
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/user_name.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.USER_NAME return varchar2
is
l_logname varchar2(30);
begin
    select logname into l_logname
      from staff$base
     where id = user_id;
    return l_logname;
end user_name;
/
 show err;
 
PROMPT *** Create  grants  USER_NAME ***
grant EXECUTE                                                                on USER_NAME       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/user_name.sql =========*** End *** 
 PROMPT ===================================================================================== 
 