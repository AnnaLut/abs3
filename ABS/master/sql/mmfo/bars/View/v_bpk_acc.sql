

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_ACC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_ACC ("BRANCH", "RNK", "OKPO", "NMK", "KV", "LCV", "TIP", "TIP_NAME", "ACC_PK", "NLS_PK", "DAZS_PK", "NMS_PK", "OST_PK", "LIM_PK", "ACC_OVR", "NLS_OVR", "NMS_OVR", "OST_OVR", "ACC_9129", "NLS_9129", "NMS_9129", "OST_9129", "ACC_2208", "NLS_2208", "NMS_2208", "OST_2208", "ACC_3570", "NLS_3570", "NMS_3570", "OST_3570", "ACC_2207", "NLS_2207", "NMS_2207", "OST_2207", "ACC_3579", "NLS_3579", "NMS_3579", "OST_3579", "ACC_2209", "NLS_2209", "NMS_2209", "OST_2209") AS 
  select a.branch, r.rnk, r.okpo, r.nmk, a.kv,
       decode(a.kv,980,'UAH','USD'), a.tip, s.name,
       a.acc, a.nls, a.dazs, a.nms, a.ostc/100 ost, a.lim/100 lim,
       b.acc, b.nls, b.nms, b.ostc/100,
       c.acc, c.nls, c.nms, c.ostc/100,
       d.acc, d.nls, d.nms, d.ostc/100,
       k.acc, k.nls, k.nms, k.ostc/100,
       a_2207.acc, a_2207.nls, a_2207.nms, a_2207.ostc/100,
       a_3579.acc, a_3579.nls, a_3579.nms, a_3579.ostc/100,
       a_2209.acc, a_2209.nls, a_2209.nms, a_2209.ostc/100
  from bpk_acc p, accounts a, accounts b, accounts c,
       accounts d, accounts k,
       accounts a_2207, accounts a_3579, accounts a_2209,
       customer r, tips s
 where p.acc_pk   = a.acc
   and p.acc_ovr  = b.acc(+)
   and p.acc_9129 = c.acc(+)
   and p.acc_2208 = d.acc(+)
   and p.acc_3570 = k.acc(+)
   and p.acc_2207 = a_2207.acc(+)
   and p.acc_3579 = a_3579.acc(+)
   and p.acc_2209 = a_2209.acc(+)
   and a.rnk = r.rnk
   and a.tip = s.tip
   and substr(a.branch,1,length(sys_context ('bars_context', 'user_branch'))) = sys_context ('bars_context', 'user_branch');

PROMPT *** Create  grants  V_BPK_ACC ***
grant SELECT                                                                 on V_BPK_ACC       to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BPK_ACC       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BPK_ACC       to OBPC;
grant SELECT                                                                 on V_BPK_ACC       to START1;
grant SELECT                                                                 on V_BPK_ACC       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BPK_ACC       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_BPK_ACC       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_ACC.sql =========*** End *** ====
PROMPT ===================================================================================== 
