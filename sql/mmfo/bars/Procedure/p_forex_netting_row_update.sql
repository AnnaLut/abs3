

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FOREX_NETTING_ROW_UPDATE.sql ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FOREX_NETTING_ROW_UPDATE ***

  CREATE OR REPLACE PROCEDURE BARS.P_FOREX_NETTING_ROW_UPDATE (p_rnk number,
                            p_deal_tag V_FOREX_NETTING.deal_tag%type,
                            p_kva V_FOREX_NETTING.kva%type,
                            p_kvb V_FOREX_NETTING.kvb%type,
                            p_neta V_FOREX_NETTING.neta%type,
                            p_netb V_FOREX_NETTING.netb%type,
                            p_detali V_FOREX_NETTING.detali%type)
is
l_v_forex_netting V_FOREX_NETTING%rowtype;
begin
    select v.* into l_V_FOREX_NETTING from V_FOREX_NETTING v
    where v.rnk=p_rnk and v.deal_tag=p_deal_tag;

      if l_V_FOREX_NETTING.rnk is null and p_rnk is not null then
     update fx_deal set rnk = p_rnk where DEAL_TAG = l_V_FOREX_NETTING.DEAL_TAG;
  end if;

  If Nvl(l_V_FOREX_NETTING.NETA,0)   =0  and nvl(p_NETA,0)    = 1  then
     update fx_deal set neta = 1, detali = p_detali    where deal_tag = p_deal_tag;
     insert into tmp_irr_user (n,s)  values (p_deal_tag,p_KVA);

  elsIf Nvl(l_V_FOREX_NETTING.NETA,0)=1  and nvl(p_NETA,0)    = 0  then
     delete from tmp_irr_user where n = p_deal_tag and userid=user_id;
     update fx_deal set neta = null where deal_tag  = p_deal_tag;
  end if;

  If nvl(l_V_FOREX_NETTING.NETB,0)   =0 and nvl(p_NETB,0)     = 1 then
     update fx_deal set netb = 1, detali = p_detali    where deal_tag = p_deal_tag;
     insert into tmp_irr_user (n,s)  values (p_deal_tag,p_KVB);

  elsif nvl(l_V_FOREX_NETTING.NETB,0)=1 and nvl(p_NETB,0)     = 0 then
     delete from tmp_irr_user where n = p_deal_tag  and userid=user_id;
     update fx_deal set netb = null where deal_tag  = p_deal_tag;
  end if;

end p_forex_netting_row_update;
/
show err;

PROMPT *** Create  grants  P_FOREX_NETTING_ROW_UPDATE ***
grant EXECUTE                                                                on P_FOREX_NETTING_ROW_UPDATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FOREX_NETTING_ROW_UPDATE.sql ===
PROMPT ===================================================================================== 
