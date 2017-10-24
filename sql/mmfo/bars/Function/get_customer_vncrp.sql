
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_customer_vncrp.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_CUSTOMER_VNCRP (p_rnk number, p_dat date) return varchar2
is
  l_vncrp customer_field.tag%type := 'VNCRP';
  l_value customerw_update.value%type;
begin
  begin
     select value into l_value
       from customerw_update w
      where rnk = p_rnk and tag = l_vncrp
        and idupd = (select max(idupd) from customerw_update where rnk = w.rnk and tag = w.tag and chgdate <= p_dat);
  exception when no_data_found then
     begin
        select value into l_value
          from customerw_update w
         where rnk = p_rnk and tag = l_vncrp
           and idupd = (select min(idupd) from customerw_update where rnk = w.rnk and tag = w.tag);
     exception when no_data_found then
        l_value := null;
     end;
  end;
  return l_value;
end get_customer_vncrp;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_customer_vncrp.sql =========***
 PROMPT ===================================================================================== 
 