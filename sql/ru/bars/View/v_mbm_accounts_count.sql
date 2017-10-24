CREATE OR REPLACE FORCE VIEW V_MBM_ACCOUNTS_COUNT
AS
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


GRANT SELECT ON V_MBM_ACCOUNTS_COUNT TO BARS_ACCESS_DEFROLE;	
