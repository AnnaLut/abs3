

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_SYNC_ACCOUNTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SYNC_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_SYNC_ACCOUNTS ("KF", "ACC", "ACC_ID", "ACC_NUM", "CUR_ID", "CUR_CODE", "CUR_NAME", "OPENED", "LAST_MOVEMENT", "EXEC_ID", "EXEC_NAME", "NAME", "LIMIT", "BALANCE", "BALANCE_EQ", "DEBIT_TURNS", "CREDIT_TURNS", "DEBIT_TURNS_EQ", "CREDIT_TURNS_EQ", "PAF_ID", "TYPE", "PAYOFF_DATE", "CLOSED", "GROUP_ID", "CUST_ID", "BRANCH_ID", "BRANCH_NAME", "BANK_ID", "IMPORTED") AS 
  select
a.kf, a.acc, decode(va.acc_num, null, null, 1), a.nls, a.kv, v.lcv, v.name, a.daos, a.dapp,
a.isp, s.fio, a.nms, a.lim, a.ostc, a.ostq,
a.dos, a.kos, a.dosq, a.kosq, a.pap, a.tip,
a.mdate, a.dazs, a.grp, a.rnk, a.tobo, t.name, a.kf, decode(va.acc_num, null, 0, 1)
from barsaq.v_kf_accounts a,
	 bars.tabval v,
	 bars.tobo t,
	 bars.staff s,
	 barsaq.accounts va
where a.kv = v.kv
  and a.tobo = t.tobo
  and a.isp = s.id
  and a.dazs is null
  and a.kf = va.bank_id (+)
  and a.nls = va.acc_num (+)
  and a.kv = va.cur_id (+)
  ;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_SYNC_ACCOUNTS.sql =========*** End 
PROMPT ===================================================================================== 
