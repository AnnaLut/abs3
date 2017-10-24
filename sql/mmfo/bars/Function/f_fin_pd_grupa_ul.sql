
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_fin_pd_grupa_ul.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_FIN_PD_GRUPA_UL (p_tip integer, p_fin integer, p_rpb number) RETURN number is

/* Версия 1.0 19-12-2016
   для Юр.лиц
   p_tip = 1  - PD
   P_tip = 2  - LGD для ГРН.
   Другое       LGD для ВАЛ.
*/

 l_pd number;

begin
   begin
      select  decode(p_tip, 1, pd, 2, lgd, lgdv) into l_pd from REZ_FIN_PD_GRUPA_UL where p_rpb BETWEEN pr_min AND pr_max;
   exception when NO_DATA_FOUND THEN l_pd := 0;
   end;
   return l_pd;
end;
/
 show err;
 
PROMPT *** Create  grants  F_FIN_PD_GRUPA_UL ***
grant EXECUTE                                                                on F_FIN_PD_GRUPA_UL to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_FIN_PD_GRUPA_UL to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_fin_pd_grupa_ul.sql =========*** 
 PROMPT ===================================================================================== 
 