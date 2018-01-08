

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SOCIALCONTRACTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SOCIALCONTRACTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SOCIALCONTRACTS ("CONTRACT_ID", "CONTRACT_NUMBER", "CONTRACT_DATE_ON", "CONTRACT_DATE_OFF", "CARD_ACCOUNT", "PENSION_NUM", "TYPE_ID", "TYPE_NAME", "ACC_TYPE", "DPT_VIDD", "CARD_TYPE", "AGENCY_ID", "AGENCY_NAME", "BRANCH_ID", "BRANCH_NAME", "CUSTOMER_ID", "CUSTOMER_NAME", "CUSOMER_CODE", "ACCOUNT_ID", "ACCOUNT_NUMBER", "ACCOUNT_NAME", "ACCOUNT_SALDO", "CURRENCY_ID", "CURRENCY_CODE", "CURRENCY_NAME", "RATE", "DETAILS", "INTEREST_ID", "INTEREST_NUMBER", "INTEREST_NAME", "INTEREST_SALDO", "INTEREST_SALDO_PL") AS 
  SELECT s.contract_id, s.contract_num, s.contract_date, s.closed_date,
       s.card_account, s.pension_num, s.type_id,
       d.name, d.acc_type, d.dpt_vidd, d.card_type,
       s.agency_id, g.name, s.branch, b.name,
       s.rnk, c.nmk, c.okpo,
       s.acc, a.nls, a.nms, a.ostc,
       t.kv, t.lcv, t.name, acrn.fproc(a.acc, bankdate), s.details,
       i.acra, p.nls, p.nms, p.ostc, p.ostb
  FROM social_contracts s, social_dpt_types d, social_agency g,
       branch b, customer c, accounts a, tabval t, int_accn i, accounts p
 WHERE s.type_id = d.type_id
   AND s.agency_id = g.agency_id
   AND b.branch = s.branch
   AND s.rnk = c.rnk
   AND a.acc = s.acc
   AND a.kv = t.kv
   AND a.acc = i.acc(+)
   AND i.acra = p.acc(+)
 ;

PROMPT *** Create  grants  V_SOCIALCONTRACTS ***
grant SELECT                                                                 on V_SOCIALCONTRACTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_SOCIALCONTRACTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SOCIALCONTRACTS to DPT_ROLE;
grant SELECT                                                                 on V_SOCIALCONTRACTS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SOCIALCONTRACTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SOCIALCONTRACTS.sql =========*** End 
PROMPT ===================================================================================== 
