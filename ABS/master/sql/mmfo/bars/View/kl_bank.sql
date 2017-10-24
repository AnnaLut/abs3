

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KL_BANK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view KL_BANK ***

  CREATE OR REPLACE FORCE VIEW BARS.KL_BANK ("SAB", "NMK") AS 
  SELECT   SUBSTR (c.sab, 2, 3), c.nmk
       FROM   CUSTOMER c
      WHERE       c.sab IS NOT NULL
              AND c.custtype in (2,3)
              AND SUBSTR (c.sab, 1, 1) = 'C'
              AND SUBSTR (c.sab, 2, 1) IN
                       ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0')
              AND SUBSTR (c.sab, 3, 1) IN
                       ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0')
              AND SUBSTR (c.sab, 4, 1) IN
                       ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0')
   ORDER BY   c.SAB;

PROMPT *** Create  grants  KL_BANK ***
grant SELECT                                                                 on KL_BANK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_BANK         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KL_BANK.sql =========*** End *** ======
PROMPT ===================================================================================== 
