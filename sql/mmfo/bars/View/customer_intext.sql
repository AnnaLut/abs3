

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CUSTOMER_INTEXT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view CUSTOMER_INTEXT ***

  CREATE OR REPLACE FORCE VIEW BARS.CUSTOMER_INTEXT ("RNK", "INTEXT") AS 
  select rnk, 1 from customer
union all
select id, 0 from customer_extern
 ;

PROMPT *** Create  grants  CUSTOMER_INTEXT ***
grant SELECT                                                                 on CUSTOMER_INTEXT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_INTEXT to CUST001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_INTEXT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CUSTOMER_INTEXT.sql =========*** End **
PROMPT ===================================================================================== 
