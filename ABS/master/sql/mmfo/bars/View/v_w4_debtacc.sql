

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_DEBTACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_DEBTACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_DEBTACC ("ND", "BRANCH", "RNK", "NMK", "OKPO", "ACC", "OB22", "NLS", "DAOS1", "DAOS2", "DAPP_PK", "OST_PK", "DAPP_2627", "OST_2627", "DAPP_OVR", "OST_OVR", "DAPP_2207", "OST_2207", "DAPP_2208", "OST_2208", "DAPP_2209", "OST_2209", "DAPP_3570", "OST_3570", "DAPP_3579", "OST_3579") AS 
  select o.nd, a.branch, c.rnk, c.nmk, c.okpo, a.acc, a.ob22, a.nls,
       a.daos daos1, a.daos daos2,
       a.dapp  dapp_pk,   a.ostc/100       ost_pk,
       a2.dapp dapp_2627, abs(a2.ostc)/100 ost_2627,
       b.dapp  dapp_ovr,  abs(b.ostc)/100  ost_ovr,
       a7.dapp dapp_2207, abs(a7.ostc)/100 ost_2207,
       a8.dapp dapp_2208, abs(a8.ostc)/100 ost_2208,
       a9.dapp dapp_2209, abs(a9.ostc)/100 ost_2209,
       k.dapp  dapp_3570, abs(k.ostc)/100  ost_3570,
       k9.dapp dapp_3579, abs(k9.ostc)/100 ost_3579
  from w4_acc o, accounts a, customer c, accounts a2,
       accounts b, accounts a7, accounts a8, accounts a9, accounts k, accounts k9
 where o.acc_pk = a.acc
   and a.dazs is null
   and a.rnk = c.rnk
   and o.acc_2627 = a2.acc(+)
   and o.acc_ovr  = b.acc(+)
   and o.acc_2207 = a7.acc(+)
   and o.acc_2208 = a8.acc(+)
   and o.acc_2209 = a9.acc(+)
   and o.acc_3570 = k.acc(+)
   and o.acc_3579 = k9.acc(+)
   and o.acc_9129 is not null
   and a.branch like sys_context ('bars_context', 'user_branch_mask')
 order by a.branch, c.nmk;

PROMPT *** Create  grants  V_W4_DEBTACC ***
grant SELECT                                                                 on V_W4_DEBTACC    to BARSREADER_ROLE;
grant SELECT                                                                 on V_W4_DEBTACC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_DEBTACC    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_DEBTACC.sql =========*** End *** =
PROMPT ===================================================================================== 
