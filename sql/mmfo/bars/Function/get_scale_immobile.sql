
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_scale_immobile.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_SCALE_IMMOBILE (p_kv tabval.kv%type) return number
is
l_res number;
begin
 begin
     select nvl(val,0) into l_res
      from scale_immobile
     where kv=p_kv;
 exception when no_data_found then
    l_res:=0;
 end;
 RETURN l_res;
end get_scale_immobile;
/
 show err;
 
PROMPT *** Create  grants  GET_SCALE_IMMOBILE ***
grant EXECUTE                                                                on GET_SCALE_IMMOBILE to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_scale_immobile.sql =========***
 PROMPT ===================================================================================== 
 