

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOSTRO_ACCOUNTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOSTRO_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NOSTRO_ACCOUNTS ("BIC", "NAME", "ACC", "NLS", "KV", "LCV", "NMS", "THEIR_ACC") AS 
  select n.bic, sw.name, n.acc, a.nls, a.kv, t.lcv, a.nms, n.their_acc
  from bic_acc n, accounts a, tabval t, sw_banks sw
 where a.acc=n.acc and t.kv=a.kv and sw.bic=n.bic
 ;

PROMPT *** Create  grants  V_NOSTRO_ACCOUNTS ***
grant SELECT                                                                 on V_NOSTRO_ACCOUNTS to BARS013;
grant SELECT                                                                 on V_NOSTRO_ACCOUNTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_NOSTRO_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NOSTRO_ACCOUNTS to START1;
grant SELECT                                                                 on V_NOSTRO_ACCOUNTS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_NOSTRO_ACCOUNTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOSTRO_ACCOUNTS.sql =========*** End 
PROMPT ===================================================================================== 
