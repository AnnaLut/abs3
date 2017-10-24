

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_CUSTOMERS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_CUSTOMERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_CUSTOMERS ("RNK", "OKPO", "NMK", "DATE_ON") AS 
  select c.rnk, c.okpo, c.nmk, c.date_on
  from customer c
 where c.custtype = 3
   and c.date_off is null
 order by c.rnk desc;

PROMPT *** Create  grants  V_WCS_CUSTOMERS ***
grant SELECT                                                                 on V_WCS_CUSTOMERS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_CUSTOMERS.sql =========*** End **
PROMPT ===================================================================================== 
