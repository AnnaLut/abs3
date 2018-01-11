

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_DEAL_INT_RECKONING.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBDK_DEAL_INT_RECKONING ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_DEAL_INT_RECKONING ("ID", "INTERST_ACCOUNT", "INCOME_ACCOUNT", "DATE_FROM", "DATE_TO", "ACCOUNT_REST", "INTEREST_RATE", "INTEREST_AMOUNT", "OPERATION_TYPE", "PURPOSE", "MESSAGE", "STATE_ID") AS 
  select t.id,
       ia.nls interst_account,
       pea.nls income_account,
       t.date_from,
       t.date_to,
       t.account_rest / 100 account_rest,
       t.interest_rate,
       t.interest_amount / 100 interest_amount,
       i.tt operation_type,
       t.purpose,
       t.message,
       t.state_id
from   int_reckoning t
join   cc_deal d on d.nd = t.deal_id
join   cc_add dd on dd.nd = d.nd and dd.adds = 0
join   customer c on c.rnk = d.rnk
join   custbank cb on cb.rnk = d.rnk
join   accounts a on a.acc = dd.accs
join   int_accn i on i.acc = a.acc and i.id = a.pap - 1
join   accounts ia on ia.acc = i.acra
join   accounts pea on pea.acc = i.acrb
where  t.reckoning_id = sys_context('bars_pul', 'reckoning_id');

PROMPT *** Create  grants  V_MBDK_DEAL_INT_RECKONING ***
grant SELECT                                                                 on V_MBDK_DEAL_INT_RECKONING to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBDK_DEAL_INT_RECKONING to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBDK_DEAL_INT_RECKONING to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBDK_DEAL_INT_RECKONING.sql =========
PROMPT ===================================================================================== 
