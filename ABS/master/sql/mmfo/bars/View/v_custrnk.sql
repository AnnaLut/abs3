

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTRNK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTRNK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTRNK ("RNK", "NMK", "NLS_2909") AS 
  SELECT CIN_CUST.RNK AS RNK, CUSTOMER.NMK, CIN_CUST.NLS_2909 NLS_2909
       FROM CIN_CUST, CUSTOMER
      WHERE CUSTOMER.RNK(+) = CIN_CUST.RNK
   ORDER BY CIN_CUST.RNK ASC;

PROMPT *** Create  grants  V_CUSTRNK ***
grant SELECT                                                                 on V_CUSTRNK       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTRNK.sql =========*** End *** ====
PROMPT ===================================================================================== 
