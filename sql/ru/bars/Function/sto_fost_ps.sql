
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/sto_fost_ps.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.STO_FOST_PS (p_nls varchar, p_kv number,p_sumo number,p_date date)

return number

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%  ¬озврат остатка на текущую дату

%%%  смотрим по счету и валюте

%%%  с учетом неснижаемого остатка(p_sumo)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

is

   l_acc integer;

   l_ost number;

begin

  begin

      select acc into l_acc from accounts where nls=p_nls and kv=p_kv;

      --l_ost := abs(nvl(fost(l_acc, p_date),0));
      l_ost := case when nvl(fost(l_acc, p_date),0)-nvl(p_sumo,0)>0 then nvl(fost(l_acc, p_date),0)-nvl(p_sumo,0) else 0 end;


  exception when no_data_found then

     l_ost := 0;

  end ;

  RETURN l_ost;

end;
/
 show err;
 
PROMPT *** Create  grants  STO_FOST_PS ***
grant EXECUTE                                                                on STO_FOST_PS     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on STO_FOST_PS     to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/sto_fost_ps.sql =========*** End **
 PROMPT ===================================================================================== 
 