
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_nd_val_s.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_ND_VAL_S (p_tag varchar2, p_nd integer, p_dat01 date, p_tipa integer, p_RNK INTEGER) RETURN varchar2 is

 l_val_s varchar2(500);

begin
   begin
      execute immediate 'select   trim(' || p_tag   || ') from nd_val
                         where fdat  = :p_dat01 and rnk  = :p_rnk and nd  = :p_nd and tipa = :p_tipa'
                         into l_val_s using p_dat01, p_rnk, p_nd, p_tipa;
   exception when NO_DATA_FOUND THEN l_val_s := '0';
   end;
   return l_val_s;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_ND_VAL_S ***
grant EXECUTE                                                                on F_GET_ND_VAL_S  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_ND_VAL_S  to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_nd_val_s.sql =========*** End
 PROMPT ===================================================================================== 
 