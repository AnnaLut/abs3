

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_CIGPO.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_CIGPO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_CIGPO ("RNK", "TAG", "VALUE") AS 
  select rnk, tag, value
         from customerw 
     where   tag='CIGPO';

PROMPT *** Create  grants  V_CUSTOMER_CIGPO ***
grant SELECT                                                                 on V_CUSTOMER_CIGPO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_CIGPO to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_CIGPO.sql =========*** End *
PROMPT ===================================================================================== 
