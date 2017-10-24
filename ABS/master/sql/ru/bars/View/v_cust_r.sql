

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUST_R.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUST_R ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUST_R ("RNK", "NMK", "OKPO", "ADR", "RISK") AS 
  SELECT c.rnk RNK,
            c.nmk NMK,
            c.okpo OKPO,
            c.adr ADR,
            w.value RISK
       FROM customer c,
            customerw w
      WHERE c.rnk = w.rnk AND w.tag = 'RIZIK';

PROMPT *** Create  grants  V_CUST_R ***
grant SELECT                                                                 on V_CUST_R        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUST_R        to CUST001;
grant SELECT                                                                 on V_CUST_R        to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_R.sql =========*** End *** =====
PROMPT ===================================================================================== 
