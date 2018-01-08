

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CUST_EL2.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CUST_EL2 ***

  CREATE OR REPLACE FORCE VIEW BARS.CUST_EL2 ("NMK", "RNK") AS 
  SELECT nvl(sab,'____')||'  '||nmk,
         rnk
  FROM   customer;

PROMPT *** Create  grants  CUST_EL2 ***
grant SELECT                                                                 on CUST_EL2        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUST_EL2        to REF0000;
grant SELECT                                                                 on CUST_EL2        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUST_EL2        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CUST_EL2.sql =========*** End *** =====
PROMPT ===================================================================================== 
