

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CRSOUR_DEAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CRSOUR_DEAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CRSOUR_DEAL ("ND", "CONTRACT_NUMBER", "PRODUCT_ID", "OPEN_DATE", "EXPIRY_DATE", "DEAL_AMOUNT", "CURRENCY_ID", "INTEREST_RATE", "INTEREST_BASE", "INTEREST_AMOUNT", "MAIN_ACCOUNT", "INTEREST_ACCOUNT", "OWNER_MFO", "OWNER_NAME", "PARTNER_MFO", "PARTNER_NAME", "PARTNER_MAIN_ACCOUNT", "PARTNER_INTEREST_ACCOUNT", "PARTNER_ID") AS 
  select d.nd,
       d.cc_id contract_number,
       d.vidd product_id,
       d.sdate open_date,
       d.wdate expiry_date,
       dd.s deal_amount,
       dd.kv currency_id,
       (select min(ir.ir) keep (dense_rank last order by ir.bdat)
        from   int_ratn ir
        where  ir.acc = dd.accs and
               ir.id = case when d.vidd = 3902 then 0 else 1 end and
               ir.bdat <= bankdate()) interest_rate,
       ia.basey interest_base,
       0 interest_amount,
       a.nls main_account,
       aa.nls interest_account,
       d.kf owner_mfo,
       (select cc.nmk from customer cc
        where  cc.rnk = branch_attribute_utl.get_value(bars_context.make_branch(d.kf), 'RNK')) owner_name,
       cb.mfo partner_mfo,
       c.nmk partner_name,
       dd.acckred partner_main_account,
       dd.accperc partner_interest_account,
       d.rnk partner_id
from   cc_deal d
join   cc_add dd on dd.nd = d.nd and dd.adds = 0
left join customer c on c.rnk = d.rnk
left join custbank cb on cb.rnk = c.rnk
left join accounts a on a.acc = dd.accs
left join int_accn ia on ia.acc = a.acc and
                         ia.id = case when d.vidd = 3902 then 0 else 1 end
left join accounts aa on aa.acc = ia.acra
where d.vidd in (3902, 3903);

PROMPT *** Create  grants  V_CRSOUR_DEAL ***
grant SELECT                                                                 on V_CRSOUR_DEAL   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CRSOUR_DEAL.sql =========*** End *** 
PROMPT ===================================================================================== 
