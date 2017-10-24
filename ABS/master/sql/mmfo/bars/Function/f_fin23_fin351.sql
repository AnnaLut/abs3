
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_fin23_fin351.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_FIN23_FIN351 (p_fin23 integer, p_kol integer) RETURN number is

/* Версия 1.0 01-09-2016
   Визначення класу клієнтів  по класу 23 постанови
   -------------------------------------

 */

 l_fin number;

begin
   begin
      select  fin351 into l_fin from FIN23_FIN351 where fin23 = p_fin23 and p_kol BETWEEN kol_min AND kol_max;
   exception when NO_DATA_FOUND THEN l_fin := p_fin23;
   end;
   return l_fin;
end;
/
 show err;
 
PROMPT *** Create  grants  F_FIN23_FIN351 ***
grant EXECUTE                                                                on F_FIN23_FIN351  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_FIN23_FIN351  to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_fin23_fin351.sql =========*** End
 PROMPT ===================================================================================== 
 