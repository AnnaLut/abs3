

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_TRANSIT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_TRANSIT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_TRANSIT ("ACC", "NLS", "LCV", "NMS", "BRANCH", "OSTC", "OSTB") AS 
  select a.acc, a.nls, t.lcv, a.nms, a.branch,
       a.ostc/power(10,t.dig), a.ostb/power(10,t.dig)
  from accounts a, tabval$global t
 where a.kv = t.kv
   and (a.nls like '2924%' or a.nls like '2909%')
   and a.dazs is null 
 ;

PROMPT *** Create  grants  V_BPK_TRANSIT ***
grant SELECT                                                                 on V_BPK_TRANSIT   to BARSREADER_ROLE;
grant SELECT                                                                 on V_BPK_TRANSIT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BPK_TRANSIT   to OBPC;
grant SELECT                                                                 on V_BPK_TRANSIT   to UPLD;
grant FLASHBACK,SELECT                                                       on V_BPK_TRANSIT   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_TRANSIT.sql =========*** End *** 
PROMPT ===================================================================================== 
