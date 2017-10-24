CREATE OR REPLACE FORCE VIEW V_MBM_PRODUCT_QUANTITIES
AS
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


GRANT SELECT ON V_MBM_PRODUCT_QUANTITIES TO BARS_ACCESS_DEFROLE; 