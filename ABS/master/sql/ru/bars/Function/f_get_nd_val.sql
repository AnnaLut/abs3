
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_nd_val.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_ND_VAL (p_nd integer, p_dat01 date, p_tipa integer, p_RNK INTEGER) RETURN NUMBER is

 l_kol number;

begin
   begin
      select nvl(kol,0) into l_kol from nd_val  where fdat = p_dat01 and rnk = p_rnk and nd = p_nd and tipa = p_tipa;
   exception when NO_DATA_FOUND THEN l_kol := 0;
   end;
   return l_kol;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_ND_VAL ***
grant EXECUTE                                                                on F_GET_ND_VAL    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_ND_VAL    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_nd_val.sql =========*** End *
 PROMPT ===================================================================================== 
 