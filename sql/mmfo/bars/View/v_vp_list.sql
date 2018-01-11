

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_VP_LIST.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_VP_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_VP_LIST ("ACC3800", "KV3800", "NLS3800", "OST3800", "ACC3801", "KV3801", "NLS3801", "OST3801", "ACC6204", "KV6204", "NLS6204", "OST6204") AS 
  select
l.acc3800,a.kv,a.nls,a.ostc,
l.acc3801,b.kv,b.nls,b.ostc,
l.acc6204,c.kv,c.nls,c.ostc
from vp_list l,accounts a,accounts b,accounts c
where
l.acc3800=a.acc and
l.acc3801=b.acc and
l.acc6204=c.acc
;

PROMPT *** Create  grants  V_VP_LIST ***
grant SELECT                                                                 on V_VP_LIST       to BARSREADER_ROLE;
grant SELECT                                                                 on V_VP_LIST       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_VP_LIST       to START1;
grant SELECT                                                                 on V_VP_LIST       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_VP_LIST.sql =========*** End *** ====
PROMPT ===================================================================================== 
