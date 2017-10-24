
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_nd_tip_fin.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_ND_TIP_FIN (p_nd integer, p_dat01 date,p_rnk integer,p_tipa integer) RETURN integer is

/* Версия 1.0 23-01-2017
   Параметр s080 по номеру договора
*/


 l_tip_fin integer;

begin
   begin
      select tip_fin into l_tip_fin from nd_val n where fdat = p_dat01 and nd = p_nd and rnk=p_rnk and tipa=p_tipa;
   exception when NO_DATA_FOUND THEN l_tip_fin := NULL;
   end;
   return l_tip_fin;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_ND_TIP_FIN ***
grant EXECUTE                                                                on F_GET_ND_TIP_FIN to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_ND_TIP_FIN to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_nd_tip_fin.sql =========*** E
 PROMPT ===================================================================================== 
 