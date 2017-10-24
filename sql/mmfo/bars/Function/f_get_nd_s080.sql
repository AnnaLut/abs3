
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_nd_s080.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_ND_S080 (p_nd integer, p_dat01 date) RETURN varchar2 is

/* Версия 1.0 23-01-2017
   Параметр s080 по номеру договора
*/


 l_s080 varchar2(1);

begin
   begin
      select s080 into l_s080 from nd_val n where fdat = p_dat01 and nd = p_nd and rownum=1;
   exception when NO_DATA_FOUND THEN l_s080 := NULL;
   end;
   return l_s080;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_ND_S080 ***
grant EXECUTE                                                                on F_GET_ND_S080   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_ND_S080   to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_nd_s080.sql =========*** End 
 PROMPT ===================================================================================== 
 