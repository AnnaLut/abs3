 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_nd_val_n.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_ND_VAL_N (p_tag varchar2, p_nd integer, p_dat01 date, p_tipa integer, p_OKPO varchar2) RETURN NUMBER is

 l_val_n number;

begin
   begin
      execute immediate 'select    max(nvl(' || p_tag   || ',0)) from nd_val
                         where fdat  = :p_dat01 and okpo = :p_okpo and nd  = :p_nd and tipa = :p_tipa'
                         into l_val_n using p_dat01, p_okpo, p_nd, p_tipa;
   exception when NO_DATA_FOUND THEN l_val_n := 0;
   end;
   if l_val_n is null THEN 
      p_error_351( P_dat01, p_nd, user_id, 44, null, null, null, null, 'Не нашла ' || p_tag || ' в nd_val, OKPO = ' || p_okpo || ' tipa = ' || p_tipa , 999, null);
   end if;
   return nvl(l_val_n,0);
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_ND_VAL_N ***
grant EXECUTE                                                                on F_GET_ND_VAL_N  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_ND_VAL_N  to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_nd_val_n.sql =========*** End
 PROMPT ===================================================================================== 
 