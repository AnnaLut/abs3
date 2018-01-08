
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_rez_kol_fin_pd.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_REZ_KOL_FIN_PD (p_deb integer, p_tip integer, p_kol number) RETURN number is

/* Версия 2.0  22-06-2017  22-08-2016
   Определение класа контрагента по к-ву дней просрочки
   -------------------------------------
   1) 22-06-2017 Разделение на хоз.дебиторку и фин.дебиторку

   p_tip: 1 - Клас контрагента
          2 - Значення коефіцієнту імовірності дефолту
 */

 l_fin number; l_pd number;

begin
   select fin, pd  into   l_fin, l_pd from REZ_DEB_KOL_FIN_PD where deb = p_deb and p_kol BETWEEN kol_min AND kol_max;
   if p_tip=1 THEN return l_fin;
   else            return l_pd;
   end if;
end;
/
 show err;
 
PROMPT *** Create  grants  F_REZ_KOL_FIN_PD ***
grant EXECUTE                                                                on F_REZ_KOL_FIN_PD to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_REZ_KOL_FIN_PD to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_rez_kol_fin_pd.sql =========*** E
 PROMPT ===================================================================================== 
 