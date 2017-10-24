CREATE OR REPLACE VIEW V_INTEREST_CCK_ND AS
SELECT d.nd deal_id
      ,t.account_id
      ,t.interest_kind
      ,d.nd deal_number
      ,a.kv currency_id
      ,a.kf mfo
      ,c.nmk partner_name
      ,a.nls account_number
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
 WHERE t.deal_id = sys_context('bars_pul', 'ND')
  and  t.reckoning_id = sys_context('bars_pul', 'reckoning_id')
   AND t.interest_amount > 0
   and t.oper_ref is null;
