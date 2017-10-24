
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getusercashex.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETUSERCASHEX (p_id in number)
return varchar2 is
  v_nls  varchar2(15);
begin
  begin
    select nls into v_nls from cash_user where id=p_id;
  exception when no_data_found then
    v_nls := null;
  end;
  return v_nls;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getusercashex.sql =========*** End 
 PROMPT ===================================================================================== 
 