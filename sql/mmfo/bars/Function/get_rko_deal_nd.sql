
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_rko_deal_nd.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_RKO_DEAL_ND 
( p_acc1 RKO_LST.ACC1%type
) return number
is
  PRAGMA AUTONOMOUS_TRANSACTION;
  l_nd   RKO_LST.ND%type;
begin

  select min(ND)
    into l_nd
    from BARS.RKO_LST
   where ACC1 = p_acc1;

  return coalesce(l_nd, bars_sqnc.get_nextval('S_CC_DEAL'));

end GET_RKO_DEAL_ND;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_rko_deal_nd.sql =========*** En
 PROMPT ===================================================================================== 
 