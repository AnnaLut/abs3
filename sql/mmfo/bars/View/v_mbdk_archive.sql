

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_ARCHIVE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBDK_ARCHIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_ARCHIVE ("ND", "DEAL_TYPE_ID", "DEAL_PRODUCT_ID", "MAIN_ACCOUNT_ID", "PARTNER_ID", "AGREEMENT_DATE", "START_DATE", "EXPIRY_DATE", "DEAL_NUMBER", "PARTNER_BIC", "PARTNER_NAME", "DEAL_AMOUNT", "CURRENCY_ID", "MAIN_ACCOUNT_NUMBER", "INTEREST_ACCOUNT_NUMBER", "INTEREST_RATE", "ACCRUED_INTEREST_AMOUNT", "PAYED_INTEREST_AMOUNT", "PARTNER_ACCOUNT", "USER_NAME") AS 
  select d.nd,
       v.tipd                              deal_type_id,
       d.vidd                              deal_product_id,
       dd.accs                             main_account_id,
       c.rnk                               partner_id,
       d.sdate                             agreement_date,
       dd.bdate                            start_date,
       d.wdate                             expiry_date,
       d.cc_id                             deal_number,
       cb.bic                              partner_bic,
       c.nmk                               partner_name,
       dd.s                                deal_amount,
       dd.kv                               currency_id,
       a.nls                               main_account_number,
       ia.nls                              interest_account_number,
       acrn.fprocn(i.acc, i.id, dd.bdate)  interest_rate,
       currency_utl.from_fractional_units(
           nvl((select sum(case when a.pap = 1 then s.dos else s.kos end)
                from   saldoa s
                where  s.acc = ia.acc and
                       s.fdat >= dd.bdate and
                       s.fdat <= d.wdate), 0), a.kv) accrued_interest_amount,
       currency_utl.from_fractional_units(
           nvl((select sum(case when a.pap = 2 then s.dos else s.kos end)
                from   saldoa s
                where  s.acc = ia.acc and
                       s.fdat >= dd.bdate and
                       s.fdat <= d.wdate), 0), a.kv)  payed_interest_amount,
       dd.acckred                          partner_account,
       user_utl.get_user_name(d.user_id)   user_name
from   cc_deal d
join   cc_add dd on dd.nd = d.nd and dd.adds = 0
join   accounts a on a.acc = dd.accs
join   customer c on c.rnk = d.rnk
join   custbank cb on cb.rnk = c.rnk
join   cc_vidd v on v.vidd = d.vidd
left join int_accn i on i.acc = a.acc and i.id = a.pap - 1
left join accounts ia on ia.acc = i.acra
where  d.sos = 15 and
       mbk.check_if_deal_belong_to_mbdk(v.vidd) = 'Y'
order by d.nd desc;

PROMPT *** Create  grants  V_MBDK_ARCHIVE ***
grant SELECT                                                                 on V_MBDK_ARCHIVE  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBDK_ARCHIVE.sql =========*** End ***
PROMPT ===================================================================================== 
