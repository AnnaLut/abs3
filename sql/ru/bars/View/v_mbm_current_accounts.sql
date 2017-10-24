/* Formatted on 1/6/2016 3:23:09 PM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW V_MBM_CURRENT_ACCOUNTS
AS
   SELECT ACC_ID,
          CUST_ID,
          ACC_NUM,
          NAME,
          ALT_NAME,
          CUR_ID,
          CUR_CODE,
          OPENING_DATE,
          CLOSING_DATE,
          BANK_ID,
          BRANCH_ID,
          PAF_ID,
          TYPE_ID,
          LOCK_DEBIT_CODE,
          LOCK_CREDIT_CODE,
          LIMIT,
          FIN_DATE,
          FIN_BALANCE,
          DEBIT_TURNS,
          CREDIT_TURNS,
          EQ_DATE,
          EQ_BALANCE,
          EQ_DEBIT_TURNS,
          EQ_CREDIT_TURNS,
		  OKPO,
		  PLANNED_BALANCE
     FROM v_mbm_all_accounts
	 where type_id = 'CURRENT';


GRANT SELECT ON V_MBM_CURRENT_ACCOUNTS TO BARS_ACCESS_DEFROLE;
