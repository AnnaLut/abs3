

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FIN_DEBVC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view FIN_DEBVC ***

  CREATE OR REPLACE FORCE VIEW BARS.FIN_DEBVC ("ND", "CC_ID", "SDATE", "WDATE", "SOS", "RNK", "PROD", "MOD_ABS", "COMM", "KV", "NLS", "OSTC", "ACC") AS 
  select d.nd, d.cc_ID, d.sdate, d.wdate, d.sos, d.rnk, d.prod, f.MOD_abs, f.comm, a.kv, a.nls, a.ostc/100 ostc , a.acc
from fin_debT f, accounts a, nd_acc n, cc_deal d
 where d.sos < 15 and d.vidd in ( 137, 237,337) and d.nd = n.nd and n.acc= a.acc
   and a.nbs||a.ob22 in  ( f.nbs_n, nvl(f.nbs_p,f.nbs_n),  nvl(f.nbs_k,f.nbs_n) ) ;

PROMPT *** Create  grants  FIN_DEBVC ***
grant SELECT                                                                 on FIN_DEBVC       to BARSREADER_ROLE;
grant SELECT                                                                 on FIN_DEBVC       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_DEBVC       to START1;
grant SELECT                                                                 on FIN_DEBVC       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FIN_DEBVC.sql =========*** End *** ====
PROMPT ===================================================================================== 
