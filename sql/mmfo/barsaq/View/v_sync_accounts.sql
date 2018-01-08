

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_SYNC_ACCOUNTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SYNC_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_SYNC_ACCOUNTS ("KF", "ACC", "ACC_ID", "ACC_NUM", "CUR_ID", "CUR_CODE", "CUR_NAME", "OPENED", "LAST_MOVEMENT", "EXEC_ID", "EXEC_NAME", "NAME", "LIMIT", "BALANCE", "BALANCE_EQ", "DEBIT_TURNS", "CREDIT_TURNS", "DEBIT_TURNS_EQ", "CREDIT_TURNS_EQ", "PAF_ID", "TYPE", "PAYOFF_DATE", "CLOSED", "GROUP_ID", "CUST_ID", "BRANCH_ID", "BRANCH_NAME", "BANK_ID", "IMPORTED") AS 
  SELECT a.kf,
          a.acc,
          DECODE (va.acc_num, NULL, NULL, 1),
          a.nls,
          a.kv,
          v.lcv,
          v.name,
          a.daos,
          a.dapp,
          a.isp,
          s.fio,
          a.nms,
          a.lim,
          a.ostc,
          a.ostq,
          a.dos,
          a.kos,
          a.dosq,
          a.kosq,
          a.pap,
          a.tip,
          a.mdate,
          a.dazs,
          a.grp,
          a.rnk,
          a.tobo,
          t.name,
          a.kf,
          DECODE (va.acc_num, NULL, 0, 1)
     FROM barsaq.v_kf_accounts a,
          bars.tabval v,
          bars.tobo t,
          bars.staff$base s,
          barsaq.accounts va
    WHERE     a.kv = v.kv
          AND a.tobo = t.tobo
          AND a.isp = s.id
          AND a.dazs IS NULL
          AND a.kf = va.bank_id(+)
          AND a.nls = va.acc_num(+)
          AND a.kv = va.cur_id(+);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_SYNC_ACCOUNTS.sql =========*** End 
PROMPT ===================================================================================== 
