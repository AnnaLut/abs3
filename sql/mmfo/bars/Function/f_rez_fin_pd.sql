
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_rez_fin_pd.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_REZ_FIN_PD (p_tip integer, p_fin integer, p_kol number) RETURN number is

/* Версия 1.0 22-08-2016
   Визначення коефіцієнта імовірності дефолту контрагента за дебіторською заборгованістю > 3 міс.
   -------------------------------------
   p_tip: 1 -    Визначення коефіцієнта імовірності дефолту контрагента за дебіторською заборгованістю, щодо якого наявна інша
                 активна операція боржника – бюджетної установи, банку, фізичної особи. (таблиця №3).
          2 -    Визначення коефіцієнта імовірності дефолту контрагента за дебіторською заборгованістю, щодо якого наявна інша
                 активна операція боржника – юридичної особи (крім банку та бюджетної установи) та емітента цінних паперів,
                 що є юридичною особою (крім банку та бюджетної установи). (таблиця №2).

 */

 l_pd number;

begin
   if p_tip = 1 THEN
      begin
         select  pd  into l_pd from REZ_DEB_FIN_PD_FL where fin = p_fin and p_kol BETWEEN kol_min AND kol_max;
      exception when NO_DATA_FOUND THEN l_pd := 0;
      end;
   else
      begin
         select  pd  into l_pd from REZ_DEB_FIN_PD_UL where fin = p_fin and p_kol BETWEEN kol_min AND kol_max;
      exception when NO_DATA_FOUND THEN l_pd := 0;
      end;
   end if;
   return l_pd;
end;
/
 show err;
 
PROMPT *** Create  grants  F_REZ_FIN_PD ***
grant EXECUTE                                                                on F_REZ_FIN_PD    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_REZ_FIN_PD    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_rez_fin_pd.sql =========*** End *
 PROMPT ===================================================================================== 
 