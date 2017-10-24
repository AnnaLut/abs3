

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTREL_EPOWERS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTREL_EPOWERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTREL_EPOWERS ("RNK", "EDATE") AS 
  SELECT rnk,
             SUBSTR (TO_CHAR (edate, 'dd/mm/yyyy'), 4, 2)
          || '.'
          || SUBSTR (TO_CHAR (edate, 'dd/mm/yyyy'), 7, 4)
             edate
     FROM customer_rel
    WHERE rel_id = 20 AND edate IS NOT NULL AND sign_privs = 1;

PROMPT *** Create  grants  V_CUSTREL_EPOWERS ***
grant SELECT                                                                 on V_CUSTREL_EPOWERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTREL_EPOWERS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTREL_EPOWERS.sql =========*** End 
PROMPT ===================================================================================== 
