

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/W4_LOCAL_CARD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view W4_LOCAL_CARD ***

  CREATE OR REPLACE FORCE VIEW BARS.W4_LOCAL_CARD ("ND", "BRANCH", "ACC", "NLS", "KV", "DAOS", "OSTC", "RNK", "NMK", "OKPO") AS 
  select w.nd, a.branch, a.acc, a.nls, a.kv, a.daos, a.ostc,
       c.rnk, c.nmk, c.okpo
  from w4_acc w, accounts a, customer c
 where w.acc_pk = a.acc
   and a.tip = 'W4V'
   and a.dazs is null
   and a.rnk = c.rnk
   and a.branch like sys_context ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  W4_LOCAL_CARD ***
grant SELECT                                                                 on W4_LOCAL_CARD   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_LOCAL_CARD   to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/W4_LOCAL_CARD.sql =========*** End *** 
PROMPT ===================================================================================== 
