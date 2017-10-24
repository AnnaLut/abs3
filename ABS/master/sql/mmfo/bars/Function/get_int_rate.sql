
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_int_rate.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_INT_RATE (p_acc number, p_dat date) return number
is
  l_rate number := null;
begin
  begin
     select ir into l_rate
       from int_ratn i
     where acc = p_acc
       and bdat = ( select max(bdat) from int_ratn where acc = i.acc and bdat <= p_dat );
  exception when no_data_found then null;
  end;
  return l_rate;
end get_int_rate;
/
 show err;
 
PROMPT *** Create  grants  GET_INT_RATE ***
grant EXECUTE                                                                on GET_INT_RATE    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_INT_RATE    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_int_rate.sql =========*** End *
 PROMPT ===================================================================================== 
 