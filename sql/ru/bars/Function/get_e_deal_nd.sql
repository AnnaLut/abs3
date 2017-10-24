
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_e_deal_nd.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_E_DEAL_ND 
( p_acc36     E_DEAL$BASE.ACC36%type
) return      pls_integer
result_cache
relies_on ( E_DEAL$BASE )
is
  PRAGMA AUTONOMOUS_TRANSACTION;
  l_nd   E_DEAL$BASE.ND%type;
begin

  select min(ND)
    into l_nd
    from BARS.E_DEAL$BASE
   where ACC36 = p_acc36;

  return coalesce(l_nd, S_CC_DEAL.NextVal);

end GET_E_DEAL_ND;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_e_deal_nd.sql =========*** End 
 PROMPT ===================================================================================== 
 