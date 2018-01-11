

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FIN_DEBVB.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view FIN_DEBVB ***

  CREATE OR REPLACE FORCE VIEW BARS.FIN_DEBVB ("MOD_ABS", "COMM", "NBS_N", "NBS_P", "NBS_K", "KV", "OSTN", "KOL", "RNK", "TACC", "OSTP", "OSTK") AS 
  select x.MOD_abs, x.comm, x.nbs_n, x.nbs_p, x.nbs_k, x.kv, x.ostn, x.kol, x.rnk,  'Рахунки' tacc,
       (select sum(ostc) from accounts where nbs||ob22 = x.nbs_p and kv = x.kv and rnk = x.rnk )/100 ostp,
       (select sum(ostc) from accounts where nbs||ob22 = x.nbs_k and kv = x.kv and rnk = x.rnk)/100 ostk
 from (select f.MOD_abs, f.comm, f.nbs_n, f.nbs_p, f.nbs_k,  a.kv,  a.rnk,  sum(a.ostc)/100 ostn, count(distinct d.nd) kol
       from fin_debT f, accounts a , cc_deal d, nd_acc n
       where f.nbs_n = a.nbs||a.ob22 and a.acc= n.acc and n.nd = d.nd and d.vidd in ( 137, 237,337) and d.sos <15
       group by f.MOD_abs, f.comm, f.nbs_n, f.nbs_p, f.nbs_k, a.kv, a.rnk
        ) x;

PROMPT *** Create  grants  FIN_DEBVB ***
grant SELECT                                                                 on FIN_DEBVB       to BARSREADER_ROLE;
grant SELECT                                                                 on FIN_DEBVB       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_DEBVB       to START1;
grant SELECT                                                                 on FIN_DEBVB       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FIN_DEBVB.sql =========*** End *** ====
PROMPT ===================================================================================== 
