
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nd_lim.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ND_LIM (p_nd integer,p_dat31 date) RETURN number is

/* Версия 1.0 01-09-2016
   Визначення залишку по 8999 (LIM)
   -------------------------------------
 */

 l_ost number;

begin
   begin
      select -ost_korr(a.acc,p_Dat31,null,a.nbs)/100 into l_ost  from nd_acc n,accounts a where nd = p_nd and n.acc=a.acc and a.tip='LIM';
   EXCEPTION  WHEN NO_DATA_FOUND   THEN l_ost := 0;
   end;
   return l_ost;
end;
/
 show err;
 
PROMPT *** Create  grants  F_ND_LIM ***
grant EXECUTE                                                                on F_ND_LIM        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ND_LIM        to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nd_lim.sql =========*** End *** =
 PROMPT ===================================================================================== 
 