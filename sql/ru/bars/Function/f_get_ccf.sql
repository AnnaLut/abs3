 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_ccf.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_CCF (p_nbs integer, p_ob22 integer,p_srok integer) RETURN NUMBER is

/* Версия 1.0 20-04-2018
   Визначення CCF
*/

 l_ccf number;

begin
   begin
      select ccf into l_ccf from nbs_ob22_ccf  where nbs = p_nbs and ob22 = p_ob22 and srok = p_srok;
   exception when NO_DATA_FOUND THEN l_CCF := 100;
   end;
   return l_ccf;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_CCF ***
grant EXECUTE                                                                on F_GET_CCF      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_CCF      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_ccf.sql =========*** End ***
 PROMPT ===================================================================================== 
 