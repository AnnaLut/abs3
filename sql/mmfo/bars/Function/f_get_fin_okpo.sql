
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_fin_okpo.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_FIN_OKPO (p_rnk integer) RETURN NUMBER is

/* Версия 1.0 19-12-2016
   Фин.стан по ОКПО (список)
*/

 l_fin number;

begin
   begin
      select fin into l_fin from FIN_RNK_OKPO  where rnk = p_rnk;
   exception when NO_DATA_FOUND THEN l_fin := null;
   end;
   return l_fin;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_FIN_OKPO ***
grant EXECUTE                                                                on F_GET_FIN_OKPO  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_FIN_OKPO  to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_fin_okpo.sql =========*** End
 PROMPT ===================================================================================== 
 