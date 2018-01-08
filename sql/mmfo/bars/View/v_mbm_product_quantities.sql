

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBM_PRODUCT_QUANTITIES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBM_PRODUCT_QUANTITIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBM_PRODUCT_QUANTITIES ("CUST_ID", "ACCOUNTS", "DEPOSITS", "LOANS") AS 
  SELECT c.rnk AS cust_id,
          (SELECT COUNT (*)
             FROM V_MBM_CURRENT_ACCOUNTS a
            WHERE a.cust_id = C.RNK)
             AS accounts,
          (SELECT COUNT (*)
             FROM V_MBM_DEPOSIT_ACCOUNTS d
            WHERE d.cust_id = C.RNK)
             AS deposits,
          (SELECT COUNT (*)
             FROM V_MBM_LOAN_ACCOUNTS l
            WHERE l.cust_id = C.RNK)
             AS loans
     FROM V_MBM_CUSTOMERS c;

PROMPT *** Create  grants  V_MBM_PRODUCT_QUANTITIES ***
grant SELECT                                                                 on V_MBM_PRODUCT_QUANTITIES to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBM_PRODUCT_QUANTITIES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBM_PRODUCT_QUANTITIES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBM_PRODUCT_QUANTITIES.sql =========*
PROMPT ===================================================================================== 
