

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBM_ACCOUNTS_COUNT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBM_ACCOUNTS_COUNT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBM_ACCOUNTS_COUNT ("CUSTOMER_ID", "CURRENCY_ID", "CURRENCY_CODE", "COUNT", "BALANCE", "BALANCE_EQUIVALENT") AS 
  SELECT g.cust_id AS Customer_id,
          g.cur_id AS Currency_Id,
          g.CUR_CODE AS Currency_Code,
          g.COUNT AS COUNT,
          g.balance AS balance,
          GL.P_ICURVAL (g.cur_id, g.balance, TRUNC (SYSDATE))
             AS Balance_Equivalent
     FROM (  SELECT a.cust_id,
                    A.cur_id,
                    A.cur_code,
                    COUNT (*) AS COUNT,
                    SUM (A.fin_balance) AS balance
               FROM v_mbm_current_accounts a
			   WHERE a.CLOSING_DATE is null
           GROUP BY a.cust_id, A.cur_id, a.cur_code) g;

PROMPT *** Create  grants  V_MBM_ACCOUNTS_COUNT ***
grant SELECT                                                                 on V_MBM_ACCOUNTS_COUNT to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBM_ACCOUNTS_COUNT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBM_ACCOUNTS_COUNT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBM_ACCOUNTS_COUNT.sql =========*** E
PROMPT ===================================================================================== 
