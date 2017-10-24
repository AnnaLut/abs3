
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_pd_0.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_PD_0 ( p_dat01 date,p_acc INTEGER) RETURN number is

l_kl     NUMBER ;

begin
   l_kl := 0;
   begin
      select 1 into l_kl from rez_cr where fdat = p_dat01 and acc = p_acc and pd_0 = 1 and rownum = 1;
   EXCEPTION  WHEN NO_DATA_FOUND    THEN l_kl := 0;
   end;
   return l_kl;
end;
/
 show err;
 
PROMPT *** Create  grants  F_PD_0 ***
grant EXECUTE                                                                on F_PD_0          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_PD_0          to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_pd_0.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 