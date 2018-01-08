

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_BD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_BD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_BD ("RNK", "BD") AS 
  SELECT c.rnk rnk, TO_CHAR (ADD_MONTHS (p.bday, 300), 'MM.YYYY') bd
     FROM customer c, person p
    WHERE c.custtype = 3 AND c.rnk = p.rnk
   UNION ALL
   SELECT c.rnk rnk, TO_CHAR (ADD_MONTHS (p.bday, 540), 'MM.YYYY') bd
     FROM customer c, person p
    WHERE c.custtype = 3 AND c.rnk = p.rnk
   UNION ALL
   SELECT cb.rnka rnk, TO_CHAR (ADD_MONTHS (cb.birthday, 300), 'MM.YYYY') bd
     FROM customer c, cust_bun cb
    WHERE c.custtype = 2 AND c.rnk = cb.rnka
   UNION ALL
   SELECT cb.rnka rnk, TO_CHAR (ADD_MONTHS (cb.birthday, 540), 'MM.YYYY') bd
     FROM customer c, cust_bun cb
    WHERE c.custtype = 2 AND c.rnk = cb.rnka;

PROMPT *** Create  grants  V_CUSTOMER_BD ***
grant SELECT                                                                 on V_CUSTOMER_BD   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_BD   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_BD.sql =========*** End *** 
PROMPT ===================================================================================== 
