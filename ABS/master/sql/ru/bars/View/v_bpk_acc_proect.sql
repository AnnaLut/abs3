

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_ACC_PROECT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_ACC_PROECT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_ACC_PROECT ("BRANCH", "RNK", "OKPO", "NMK", "ND", "NLS", "KV", "ID", "NAME", "P_OKPO") AS 
  select a.branch, c.rnk, c.okpo, c.nmk, o.nd,
       a.nls, a.kv, p.id, p.name, p.okpo
  from bpk_all_accounts o, accounts a, accountsw w,
       bpk_proect p, customer c
 where o.acc_pk = a.acc and a.dazs is null
   and a.acc = w.acc
   and w.tag = 'PK_PRCT'
   and w.value = to_char (p.id)
   and a.rnk = c.rnk
   and a.branch like sys_context ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  V_BPK_ACC_PROECT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BPK_ACC_PROECT to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BPK_ACC_PROECT to OBPC;
grant FLASHBACK,SELECT                                                       on V_BPK_ACC_PROECT to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_ACC_PROECT.sql =========*** End *
PROMPT ===================================================================================== 
