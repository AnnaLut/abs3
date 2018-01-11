

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SOCIALAGENCIES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SOCIALAGENCIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SOCIALAGENCIES ("AGENCY_ID", "AGENCY_TYPE", "AGENCY_NAME", "AGENCY_BRANCH", "AGENCY_BRANCHNAME", "DEBIT_ACC", "DEBIT_NLS", "DEBIT_NMS", "DEBIT_OSTC", "DEBIT_ODBNLS", "CREDIT_ACC", "CREDIT_NLS", "CREDIT_NMS", "CREDIT_OSTC", "CREDIT_ODBNLS", "CARD_ACC", "CARD_NLS", "CARD_NMS", "CARD_OSTC", "CARD_ODBNLS", "COMISS_ACC", "COMISS_NLS", "COMISS_NMS", "COMISS_OSTC", "COMISS_ODBNLS", "CONTRACT_NUMBER", "CONTRACT_DATE", "CONTRACT_CLOSED", "AGENCY_ADDRESS", "AGENCY_PHONE", "DETAILS") AS 
  SELECT a.agency_id, a.type_id, a.NAME, a.branch, b.NAME, d.acc, d.nls,
          d.nms, d.ostc, NVL (d.nlsalt, d.nls), c.acc, c.nls, c.nms, c.ostc,
          NVL (c.nlsalt, c.nls), t.acc, t.nls, t.nms, t.ostc,
          NVL (t.nlsalt, t.nls), k.acc, k.nls, k.nms, k.ostc,
          NVL (k.nlsalt, k.nls), a.contract, a.date_on, a.date_off, a.address,
          a.phone, a.details
     FROM social_agency a,
          branch b,
          accounts d,
          accounts c,
          accounts t,
          accounts k
    WHERE a.branch = b.branch
      AND a.debit_acc = d.acc(+)
      AND a.credit_acc = c.acc
      AND a.card_acc = t.acc
      AND a.comiss_acc = k.acc(+)
      AND a.date_off IS NULL
      AND a.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask') 
 ;

PROMPT *** Create  grants  V_SOCIALAGENCIES ***
grant SELECT                                                                 on V_SOCIALAGENCIES to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SOCIALAGENCIES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SOCIALAGENCIES to BARS_CONNECT;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_SOCIALAGENCIES to DPT_ROLE;
grant SELECT                                                                 on V_SOCIALAGENCIES to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SOCIALAGENCIES to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_SOCIALAGENCIES to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SOCIALAGENCIES.sql =========*** End *
PROMPT ===================================================================================== 
