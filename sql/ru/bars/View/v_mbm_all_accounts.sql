/* Formatted on 1/6/2016 3:23:48 PM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW V_MBM_ALL_ACCOUNTS
AS
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
		  a.ostb as planned_balance
     FROM accounts a, customer c, tabval$global t, mbm_nbs_acc_types at
    WHERE a.kv = t.kv 
		AND a.nbs = at.nbs
		and a.rnk = c.rnk;

COMMENT ON TABLE V_MBM_ALL_ACCOUNTS IS 'Рахунки доступні для підлючення до мобільного банкінгу';



GRANT SELECT ON V_MBM_ALL_ACCOUNTS TO BARS_ACCESS_DEFROLE;
