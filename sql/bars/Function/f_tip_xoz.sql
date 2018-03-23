 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tip_xoz.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.f_tip_xoz (p_dat01 date, p_acc integer, p_tip char) RETURN char is

l_tip    accounts.tip%type;

begin
   begin
      select 'ODB' into l_tip from rez_xoz_tip where fdat=p_dat01 and acc=p_acc;
   EXCEPTION  WHEN NO_DATA_FOUND  THEN  l_tip := p_tip;
   end;
   return l_tip;
end;
/
 show err;
 
PROMPT *** Create  grants  f_tip_xoz ***
grant EXECUTE                                                                on f_tip_xoz      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on f_tip_xoz      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tip_xoz.sql =========*** End *** 
 PROMPT ===================================================================================== 


