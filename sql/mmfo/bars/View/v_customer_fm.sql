

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_FM.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_FM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_FM ("RNK", "NMK", "OKPO") AS 
  SELECT rnk, nmk, okpo FROM customer;

PROMPT *** Create  grants  V_CUSTOMER_FM ***
grant SELECT                                                                 on V_CUSTOMER_FM   to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUSTOMER_FM   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_FM   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_FM.sql =========*** End *** 
PROMPT ===================================================================================== 
