
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_teller_staff.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TELLER_STAFF 
(  p_userid oper.userid%type,
   p_s      oper.s%type,
   p_kv     oper.kv%type )
return int
is
    l_id    teller_staff.id%type;

begin
    select id
      into l_id
      from teller_staff
     where id = p_userid
     and status = 1
     and case when p_kv= 980 then   5000000
              when p_kv= 840 then   200000
              when p_kv= 978 then   200000
              when p_kv= 643 then   13000000
              end >= p_s;
    -- користувач в довіднику, візу не просимо
    return 0;
exception
    when no_data_found then return 1;


end f_teller_staff;
/
 show err;
 
PROMPT *** Create  grants  F_TELLER_STAFF ***
grant EXECUTE                                                                on F_TELLER_STAFF  to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_teller_staff.sql =========*** End
 PROMPT ===================================================================================== 
 