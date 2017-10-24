

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ADVANCE_CONTRACT_PAYMENTS.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ADVANCE_CONTRACT_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ADVANCE_CONTRACT_PAYMENTS ("CUSTOMER_ID", "CUSTOMER_NAME", "CONTRACT_ID", "CONTRACT_NAME", "CONTRACT_DATE", "CONTRACT_SUM", "CONTRACT_CURRENCY_CODE", "CONTRACT_CURRENCY", "PAYMENT_ID", "PAYMENT_NUMB", "PAYMENT_DATE", "PAYMENT_SUM", "PAYMENT_CURRENCY_CODE", "PAYMENT_CURRENCY", "PAYMENT_DETAILS") AS 
  SELECT t.rnk,  c.nmk, t.pid, t.name, t.dateopen, t.s/100, t.kv, v.lcv,
       p.idp, p.ref, p.fdat, p.s/100, p.kv, w.lcv, o.nazn
  FROM top_contracts t, customer c, contract_p p, oper o, tabval v, tabval w
 WHERE t.impexp = 0
   AND t.rnk = c.rnk
   AND t.pid = p.pid
   AND p.id IS NULL
   AND p.rnk = t.rnk
   AND t.impexp = p.impexp
   AND p.ref = o.ref
   AND t.kv = v.kv
   AND p.kv = w.kv
 ORDER BY t.rnk, t.pid, p.fdat;

PROMPT *** Create  grants  V_ADVANCE_CONTRACT_PAYMENTS ***
grant SELECT                                                                 on V_ADVANCE_CONTRACT_PAYMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ADVANCE_CONTRACT_PAYMENTS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ADVANCE_CONTRACT_PAYMENTS.sql =======
PROMPT ===================================================================================== 
