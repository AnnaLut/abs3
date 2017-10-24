

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_PAWN_ACCOUNT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBDK_PAWN_ACCOUNT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_PAWN_ACCOUNT ("ND", "DEAL_NUMBER", "PRIMARY_PAWN_FLAG", "PAWN_CONTRACT_NUMBER", "REGISTRY_NUMBER", "PAWN_KIND_ID", "PAWN_KIND_NAME", "PAWN_START_DATE", "PAWN_EXPIRY_DATE", "FAIR_VALUE", "PAWN_AMOUNT", "PAWN_CURRENCY_ID", "PAWN_ACCOUNT_ID", "PAWN_ACCOUNT_NUMBER", "PAWN_LOCATION_ID", "PAWN_LOCATION_NAME", "DEPOSIT_ID", "USER_NAME") AS 
  select d.nd,
       d.cc_id       deal_number,
       l.pr_12       primary_pawn_flag,
       p.cc_idz      pawn_contract_number,
       p.nree        registry_number,
       p.pawn        pawn_kind_id,
       pk.name       pawn_kind_name,
       p.sdatz       pawn_start_date,
       a.mdate       pawn_expiry_date,
       p.sv          fair_value,
       currency_utl.from_fractional_units(abs(a.ostb), a.kv) pawn_amount,
       a.kv          pawn_currency_id,
       a.acc         pawn_account_id,
       a.nls         pawn_account_number,
       p.mpawn       pawn_location_id,
       mpk.name      pawn_location_name,
       p.deposit_id,
       user_utl.get_user_name(p.idz) user_name
from   cc_deal d
join   cc_add dd on dd.nd = d.nd
join   cc_accp l on l.accs = dd.accs
join   pawn_acc p on p.acc = l.acc
join   accounts a on a.acc = p.acc and a.dazs is null
left join cc_pawn pk on pk.pawn = p.pawn
left join cc_mpawn mpk on mpk.mpawn = p.mpawn
where  mbk.check_if_deal_belong_to_mbdk(d.vidd) = 'Y' and
       d.nd = bars.pul.get_mas_ini_val('ND')
;

PROMPT *** Create  grants  V_MBDK_PAWN_ACCOUNT ***
grant SELECT                                                                 on V_MBDK_PAWN_ACCOUNT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBDK_PAWN_ACCOUNT.sql =========*** En
PROMPT ===================================================================================== 
