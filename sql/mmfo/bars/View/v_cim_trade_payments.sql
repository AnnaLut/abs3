

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_TRADE_PAYMENTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_TRADE_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_TRADE_PAYMENTS ("BOUND_ID", "CONTR_ID", "PAY_FLAG", "REF", "DIRECT", "TYPE_ID", "TYPE", "VDAT", "ACCOUNT", "NAZN", "V_PL", "S_VPL", "SK_VPL", "RATE", "S_VK", "S_PD", "ZS_VP", "ZS_VK", "CONTROL_DATE", "OVERDUE", "S_PD_AFTER", "SERVICE_CODE", "CREATE_DATE", "MODIFY_DATE", "BORG_REASON", "EA_URL") AS 
  SELECT b.bound_id, b.contr_id, b.pay_flag, b.ref, b.direct, b.type_id, b.type, b.vdat, b.account, b.nazn, b.v_pl, b.s_vpl, b.sk_vpl, b.rate,
         b.s_vk, b.s_pd, decode(b.s_vk, 0, 0, round((b.s_vpl+ decode(b.direct, 0, b.sk_vpl, -b.sk_vpl))*(b.s_vk-b.s_pd)/b.s_vk,2)) as zs_vp, b.s_vk-b.s_pd as zs_vk,
         b.control_date, case when b.s_vk>b.s_pd and trunc(bankdate)>trunc(b.control_date) then bankdate-b.control_date else 0 end as overdue,
         (select round(nvl(sum(case when nvl2(l.vmd_id,
                   (select allow_dat from v_cim_customs_decl where cim_id=(select nvl(vmd_id,0) from cim_vmd_bound where bound_id=l.vmd_id)),
                   (select allow_date from cim_acts where act_id=(select nvl(act_id,0) from cim_act_bound where bound_id=l.act_id)))>b.control_date
                   then l.s else 0 end),0)/100,2)
            from cim_link l  where l.delete_date is null and decode(b.type_id, 0, l.payment_id, l.fantom_id)=b.bound_id ) as s_pd_after,
         (select max(service_code) from cim_ape_link where decode(b.type_id,0,payment_id,fantom_id)=b.bound_id) as servce_code,
         b.create_date, b.modify_date, b.borg_reason, b.ea_url
    FROM (SELECT b.bound_id, b.contr_id, b.pay_flag, b.pay_flag_name, b.ref, b.direct, b.type_id, b.type, b.vdat, b.account,
                 b.nazn, b.v_pl, b.s_vpl, b.sk_vpl, b.rate, b.s_vk, cim_mgr.get_control_date(0, b.type_id, b.bound_id) as control_date,
                 b.create_date, b.modify_date, b.borg_reason, b.ea_url,
                 (select round(nvl(sum(s),0)/100,2) from cim_link
                   where delete_date is null and decode(b.type_id,0,payment_id,fantom_id)=b.bound_id) as s_pd
            FROM v_cim_bound_payments b /*join cim_contracts c on c.contr_type<2 and b.contr_id=c.contr_id*/ where pay_flag=0) b;

PROMPT *** Create  grants  V_CIM_TRADE_PAYMENTS ***
grant SELECT                                                                 on V_CIM_TRADE_PAYMENTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_TRADE_PAYMENTS.sql =========*** E
PROMPT ===================================================================================== 
