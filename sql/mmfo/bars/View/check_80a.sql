

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CHECK_80A.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CHECK_80A ***

  CREATE OR REPLACE FORCE VIEW BARS.CHECK_80A ("NLS", "KV", "NAMS", "VDATE", "DOS", "DOSV", "KOS", "KOSV", "OST", "OSTV") AS 
  select
      a.nls, a.kv, a.nms, b.fdat,
      GL.P_ICURVAL(a.kv, b.dos, b.fdat), b.dos,
      GL.P_ICURVAL(a.kv, b.kos, b.fdat), b.kos,
      GL.P_ICURVAL(a.kv, b.ostf-b.dos+b.kos, b.fdat), b.ostf-b.dos+b.kos
from
      accounts a, saldoa b
where
      a.acc=b.acc and (a.vid=15 or a.vid=16 or a.vid=17)
ORDER BY b.fdat, substr(a.nls,1,4), substr(a.nls,6,9), a.kv;

PROMPT *** Create  grants  CHECK_80A ***
grant SELECT                                                                 on CHECK_80A       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHECK_80A       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CHECK_80A.sql =========*** End *** ====
PROMPT ===================================================================================== 
