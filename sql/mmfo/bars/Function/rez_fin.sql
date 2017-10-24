
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/rez_fin.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.REZ_FIN (p_tip_fin integer, p_fin integer) RETURN number is

-- Приведение к единому фин класу (для проверки)

/* Версия 1.0 21-03-2017  04-10-2016 (2) 22-08-2016 --  (1) 29-07-2016

 */

L_fin  number;

begin 

   if    p_tip_fin = 1 THEN select x0 into l_fin  from fin_all  where x1 = p_fin and rownum=1;  
   elsif p_tip_fin = 2 THEN select x0 into l_fin  from fin_all  where x2 = p_fin and rownum=1;
   else  l_fin    := p_fin;
   end if;
   return(l_fin);
end;
/
 show err;
 
PROMPT *** Create  grants  REZ_FIN ***
grant EXECUTE                                                                on REZ_FIN         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REZ_FIN         to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/rez_fin.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 