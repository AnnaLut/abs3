

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NLS_KRM.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NLS_KRM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NLS_KRM ("OK", "ACC", "KV", "NLS", "RNK", "NMK", "OKPO", "NMS", "OSTC", "DAPP", "DAZS", "OSTB", "REF", "NLS_2903", "ACC_2903") AS 
  select 0 ok,   a.acc, a.kv, a.nls, a.rnk, c.nmk, c.okpo, a.nms, a.ostc/100 ostc, a.dapp, a.dazs, a.ostb/100 ostb,
          t.ref , t.nls_2903, (select acc from accounts where nls= t.nls_2903 and kv = a.kv) acc_2903
   from customer c, accounts a, TMP_NLS_KRM  t
   where a.kv = t.kv and a.nls = t.nls and a.rnk=c.rnk ;

PROMPT *** Create  grants  V_NLS_KRM ***
grant SELECT                                                                 on V_NLS_KRM       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NLS_KRM       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NLS_KRM.sql =========*** End *** ====
PROMPT ===================================================================================== 
