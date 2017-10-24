
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_fin_pd_grupa.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_FIN_PD_GRUPA (p_tip integer, p_kol number) RETURN number is

/* Версия 1.0 16-09-2016
   p_tip = 1  - фин.стан
   P_tip = 2  - PD для ГРН.
   Другое       PD для ВАЛ.
 */

 l_pd number;

begin
   begin
      select  decode(p_tip, 1, fin, 2, pd, pdv) into l_pd from REZ_FIN_PD_GRUPA where p_kol BETWEEN kol_min AND kol_max;
   exception when NO_DATA_FOUND THEN l_pd := 0;
   end;
   return l_pd;
end;
/
 show err;
 
PROMPT *** Create  grants  F_FIN_PD_GRUPA ***
grant EXECUTE                                                                on F_FIN_PD_GRUPA  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_FIN_PD_GRUPA  to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_fin_pd_grupa.sql =========*** End
 PROMPT ===================================================================================== 
 