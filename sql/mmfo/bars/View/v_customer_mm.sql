

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_MM.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_MM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_MM ("RNK", "MM") AS 
  SELECT RNK, TO_CHAR (date_on, 'MM') MM FROM v_customer;

PROMPT *** Create  grants  V_CUSTOMER_MM ***
grant SELECT                                                                 on V_CUSTOMER_MM   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_MM   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_MM.sql =========*** End *** 
PROMPT ===================================================================================== 
