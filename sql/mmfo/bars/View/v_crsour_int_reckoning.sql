

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CRSOUR_INT_RECKONING.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CRSOUR_INT_RECKONING ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CRSOUR_INT_RECKONING ("ID", "DEAL_ID", "ACCOUNT_ID", "INTEREST_KIND", "DEAL_NUMBER", "CURRENCY_ID", "PARTNER_MFO", "PARTNER_NAME", "ACCOUNT_NUMBER", "ACCOUNT_REST", "INTEREST_RATE", "INTEREST_AMOUNT", "DATE_FROM", "DATE_TO", "PURPOSE", "OPERATION_TYPE", "INTEREST_ACCOUNT_NUMBER", "INCOME_ACCOUNT", "MESSAGE", "STATE_ID") AS 
  select t.id,
       t.deal_id,
       t.account_id,
       t.interest_kind,
       d.cc_id deal_number,
       a.kv currency_id,
       cb.mfo partner_mfo,
       c.nmk partner_name,
       a.nls account_number,
       t.account_rest / 100 account_rest,
       t.interest_rate,
       t.interest_amount / 100 interest_amount,
       t.date_from,
       t.date_to,
       t.purpose,
       nvl (i.tt, '%%1') operation_type,
       ia.nls interest_account_number,
       inc.nls income_account,
       t.message,
       t.state_id
from   int_reckoning t
join cc_deal d on d.nd = t.deal_id
join accounts a on a.acc = t.account_id
join int_accn i on i.acc = a.acc and i.id = a.pap - 1
join customer c on c.rnk = a.rnk
left join accounts ia on ia.acc = i.acra
left join accounts inc on ia.acc = i.acrb
left join custbank cb on cb.rnk = c.rnk
where t.reckoning_id = sys_context ('bars_pul', 'reckoning_id');

PROMPT *** Create  grants  V_CRSOUR_INT_RECKONING ***
grant SELECT                                                                 on V_CRSOUR_INT_RECKONING to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_CRSOUR_INT_RECKONING to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CRSOUR_INT_RECKONING to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CRSOUR_INT_RECKONING.sql =========***
PROMPT ===================================================================================== 
