

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SET_COMERCIAL_RATES.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SET_COMERCIAL_RATES ***

  CREATE OR REPLACE PROCEDURE BARS.P_SET_COMERCIAL_RATES (p_vdat   date,
                                                       p_kv     number,
                                                       p_rate_b number,
                                                       p_rate_s number) is
begin
  update cur_rates$base c
     set c.rate_b = p_rate_b, c.rate_s = p_rate_s
   where c.vdate = p_vdat
     and c.kv = p_kv
     and c.branch = tobopack.get_branch;
end;
/
show err;

PROMPT *** Create  grants  P_SET_COMERCIAL_RATES ***
grant EXECUTE                                                                on P_SET_COMERCIAL_RATES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SET_COMERCIAL_RATES.sql ========
PROMPT ===================================================================================== 
