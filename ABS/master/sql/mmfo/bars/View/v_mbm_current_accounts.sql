

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBM_CURRENT_ACCOUNTS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBM_CURRENT_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBM_CURRENT_ACCOUNTS ("ACC_ID", "CUST_ID", "ACC_NUM", "NAME", "ALT_NAME", "CUR_ID", "CUR_CODE", "OPENING_DATE", "CLOSING_DATE", "BANK_ID", "BRANCH_ID", "PAF_ID", "TYPE_ID", "LOCK_DEBIT_CODE", "LOCK_CREDIT_CODE", "LIMIT", "FIN_DATE", "FIN_BALANCE", "DEBIT_TURNS", "CREDIT_TURNS", "EQ_DATE", "EQ_BALANCE", "EQ_DEBIT_TURNS", "EQ_CREDIT_TURNS", "OKPO", "PLANNED_BALANCE", "TIP", "OB22") AS 
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
	  PLANNED_BALANCE,
          tip,
          ob22
     FROM v_mbm_all_accounts
	 where type_id = 'CURRENT';

PROMPT *** Create  grants  V_MBM_CURRENT_ACCOUNTS ***
grant SELECT                                                                 on V_MBM_CURRENT_ACCOUNTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBM_CURRENT_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBM_CURRENT_ACCOUNTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBM_CURRENT_ACCOUNTS.sql =========***
PROMPT ===================================================================================== 
