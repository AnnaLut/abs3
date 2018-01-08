

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_TECH_ACCOUNTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_TECH_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_TECH_ACCOUNTS ("TECH_ACCID", "TECH_ACCNUM", "TECH_CURRENCY", "TECH_CURRENCYID", "TECH_SALDO", "TECH_DAT_OPEN", "TECH_DAT_END_PLAN", "TECH_DAT_END_FACT", "TECH_CUSTNUM", "TECH_CUSTOMER", "TECH_CUSTID", "DPT_ID", "DPT_NUM", "DPT_DAT_BEGIN", "DPT_DAT_END", "DPT_ACTIVE", "BRANCH_ID", "BRANCH_NAME") AS 
  SELECT a.acc, a.nls, t.lcv, a.kv, a.ostc,
       a.daos, d.dat_end_alt, a.dazs,
       c.rnk, c.nmk, c.okpo,
       d.deposit_id, d.nd, d.dat_begin, d.dat_end, 1,
       d.branch, b.name
  FROM dpt_deposit d, accounts a, customer c, tabval t, branch b
 WHERE d.acc_d = a.acc
   AND a.rnk = c.rnk
   AND a.kv = t.kv
   AND d.branch = b.branch
   AND a.tip = 'TCH'
UNION ALL
SELECT a.acc, a.nls, t.lcv, a.kv, a.ostc,
       a.daos, d.tech_datend, a.dazs,
       c.rnk, c.nmk, c.okpo,
       d.dpt_id, arc.nd, d.dpt_datbegin, d.dpt_datend, 0,
       d.branch, b.name
  FROM dpt_techaccounts d, dpt_deposit_clos arc, accounts a,
       customer c, tabval t, branch b
 WHERE d.tech_acc = a.acc
   AND a.rnk = c.rnk
   AND a.kv = t.kv
   AND d.branch = b.branch
   AND a.tip = 'TCH'
   AND arc.idupd = d.dpt_idupd
   AND arc.deposit_id = d.dpt_id
 ;

PROMPT *** Create  grants  V_DPT_TECH_ACCOUNTS ***
grant SELECT                                                                 on V_DPT_TECH_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_TECH_ACCOUNTS to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_TECH_ACCOUNTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_TECH_ACCOUNTS.sql =========*** En
PROMPT ===================================================================================== 
