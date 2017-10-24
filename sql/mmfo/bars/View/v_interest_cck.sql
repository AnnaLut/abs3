

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INTEREST_CCK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INTEREST_CCK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INTEREST_CCK ("DEAL_ID", "ACCOUNT_ID", "INTEREST_KIND", "DEAL_NUMBER", "CURRENCY_ID", "MFO", "PARTNER_NAME", "ACCOUNT_NUMBER", "ACCOUNT_NAME", "ACCOUNT_REST", "INTEREST_RATE", "INTEREST_AMOUNT", "DATE_FROM", "DATE_TO", "PURPOSE", "OPERATION_TYPE", "INTEREST_ACCOUNT_NUMBER", "INCOME_ACCOUNT", "MESSAGE", "STATE_ID", "ID", "RECKONING_ID", "OPER_REF") AS 
  SELECT d.nd deal_id
      ,t.account_id
      ,t.interest_kind
      ,d.nd deal_number
      ,a.kv currency_id
      ,a.kf mfo
      ,c.nmk partner_name
      ,a.nls account_number
      ,a.nms account_name
      ,nvl(t.account_rest / 100,0) account_rest
      ,t.interest_rate
      ,t.interest_amount / 100 interest_amount
      ,t.date_from
      ,t.date_to
      ,t.purpose
      ,nvl(i.tt, '%%1') operation_type
      ,ia.nls interest_account_number
      ,inc.nls income_account
      ,t.message
      ,t.state_id
      ,t.id
      ,t.reckoning_id
      ,t.oper_ref
  FROM int_reckoning t
  JOIN nd_acc d
    ON d.acc = t.account_id
  JOIN accounts a
    ON a.acc = t.account_id
  JOIN int_accn i
    ON i.acc = a.acc
   AND i.id = a.pap - 1
  JOIN customer c
    ON c.rnk = a.rnk
  LEFT JOIN accounts ia
    ON ia.acc = i.acra
  LEFT JOIN accounts inc
    ON inc.acc = i.acrb
 WHERE t.reckoning_id = sys_context('bars_pul', 'reckoning_id')
   AND t.interest_amount > 0
   and t.oper_ref is null
;

PROMPT *** Create  grants  V_INTEREST_CCK ***
grant SELECT,UPDATE                                                          on V_INTEREST_CCK  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INTEREST_CCK.sql =========*** End ***
PROMPT ===================================================================================== 
