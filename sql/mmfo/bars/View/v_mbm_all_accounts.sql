

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBM_ALL_ACCOUNTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBM_ALL_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBM_ALL_ACCOUNTS ("ACC_ID", "CUST_ID", "ACC_NUM", "NAME", "ALT_NAME", "CUR_ID", "CUR_CODE", "OPENING_DATE", "CLOSING_DATE", "BANK_ID", "BRANCH_ID", "PAF_ID", "TYPE_ID", "LOCK_DEBIT_CODE", "LOCK_CREDIT_CODE", "LIMIT", "FIN_DATE", "FIN_BALANCE", "DEBIT_TURNS", "CREDIT_TURNS", "EQ_DATE", "EQ_BALANCE", "EQ_DEBIT_TURNS", "EQ_CREDIT_TURNS", "OKPO", "PLANNED_BALANCE", "TIP", "OB22") AS 
  SELECT a.acc AS acc_id,
          a.rnk AS cust_id,
          a.nls AS acc_num,
          a.nms AS name,
          a.nlsalt AS alt_name,
          a.kv AS cur_id,
          t.lcv AS cur_code,
          a.daos AS opening_date,
          a.dazs AS closing_date,
          a.kf AS bank_id,
          a.branch AS branch_id,
          a.pap AS paf_id,                            -- признак актива/пасива
          at.type_id AS type_id,
          NVL (a.blkd, 0) AS lock_debit_code,
          NVL (a.blkk, 0) AS lock_credit_code,
          a.lim AS LIMIT,
          NVL (a.dapp, a.daos) AS fin_date,
          a.ostc AS fin_balance,
          a.dos AS debit_turns,
          a.kos AS credit_turns,
          NVL (a.dappq, a.daos) AS eq_date,
          a.ostq AS eq_balance,
          a.dosq AS eq_debit_turns,
          a.kosq AS eq_credit_turns,
	  c.OKPO,
	  a.ostb as planned_balance,
          a.tip,
          a.ob22
     FROM accounts a, customer c, tabval$global t, mbm_nbs_acc_types at
    WHERE a.kv = t.kv
		AND a.nbs = at.nbs
		and a.rnk = c.rnk;

PROMPT *** Create  grants  V_MBM_ALL_ACCOUNTS ***
grant SELECT                                                                 on V_MBM_ALL_ACCOUNTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBM_ALL_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBM_ALL_ACCOUNTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBM_ALL_ACCOUNTS.sql =========*** End
PROMPT ===================================================================================== 
