

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_GCIF.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_GCIF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_GCIF ("KF", "CUST_ID", "GCIF", "CUST_TYPE") AS 
  select KF, RNK, GCIF, CUST_TYPE
  from ( select KF, RNK, GCIF, CUST_TYPE
           from EBKC_GCIF
          union
         select SLAVE_KF, SLAVE_RNK, GCIF, CUST_TYPE
           from EBKC_SLAVE
          where SLAVE_KF = sys_context('bars_context','user_mfo')
       )
;

PROMPT *** Create  grants  V_CUSTOMER_GCIF ***
grant SELECT                                                                 on V_CUSTOMER_GCIF to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUSTOMER_GCIF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_GCIF to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_GCIF.sql =========*** End **
PROMPT ===================================================================================== 
