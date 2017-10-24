
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_port.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_PORT (p_nd integer, p_rnk integer) RETURN NUMBER is

/* Версия 1.0 19-12-2016
   Портфельный метод по ОСББ
*/

 l_s250 number;

begin
   begin
      select grp into l_s250 from rnk_nd_port  where rnk = p_rnk and nd = p_nd and rownum=1;
   exception when NO_DATA_FOUND THEN l_s250 := 0;
   end;
   return l_s250;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_PORT ***
grant EXECUTE                                                                on F_GET_PORT      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_PORT      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_port.sql =========*** End ***
 PROMPT ===================================================================================== 
 