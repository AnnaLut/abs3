

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUST_FM.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUST_FM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUST_FM ("CUST_TYPE", "RNK", "NMK", "PLAN_DATE") AS 
  SELECT c1.custtype,
            c1.rnk,
            c1.nmk,
            TO_DATE (c2.VALUE, 'DD/MM/YYYY')
       FROM customer c1, customerw c2
      WHERE     c1.rnk = c2.rnk
            AND (c1.CUSTTYPE = 2 OR (c1.CUSTTYPE = 3 AND c1.SED IN (34, 91)))
            AND c2.tag = 'IDDPL'
            AND c1.date_off IS NULL
   ORDER BY 3;

PROMPT *** Create  grants  V_CUST_FM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CUST_FM       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CUST_FM       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_FM.sql =========*** End *** ====
PROMPT ===================================================================================== 
