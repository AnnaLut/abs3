

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUST_OTC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUST_OTC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUST_OTC ("RNK", "NMK", "OKPO", "CUSTTYPE", "CODCAGENT", "TOBO") AS 
  SELECT rnk, nmk, okpo, custtype, codcagent, nvl(tobo, 0) tobo FROM customer;

PROMPT *** Create  grants  V_CUST_OTC ***
grant SELECT                                                                 on V_CUST_OTC      to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUST_OTC      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUST_OTC      to START1;
grant SELECT                                                                 on V_CUST_OTC      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_OTC.sql =========*** End *** ===
PROMPT ===================================================================================== 
