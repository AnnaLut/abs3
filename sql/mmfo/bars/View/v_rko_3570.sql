

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RKO_3570.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RKO_3570 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RKO_3570 ("KF", "ACC", "NLS", "KV", "NMS") AS 
  select a.kf, a.acc, a.nls, a.kv, a.nms
from accounts a, rko_3570 r
where a.acc=r.acc and a.kf=r.kf
 ;

PROMPT *** Create  grants  V_RKO_3570 ***
grant SELECT                                                                 on V_RKO_3570      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_RKO_3570      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_RKO_3570      to RKO;
grant SELECT                                                                 on V_RKO_3570      to UPLD;
grant FLASHBACK,SELECT                                                       on V_RKO_3570      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RKO_3570.sql =========*** End *** ===
PROMPT ===================================================================================== 
