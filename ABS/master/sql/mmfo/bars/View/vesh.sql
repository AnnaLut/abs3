

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VESH.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view VESH ***

  CREATE OR REPLACE FORCE VIEW BARS.VESH ("ACC", "NLS", "KV", "PDAT", "FDAT", "VX", "DOS", "KOS", "ISX") AS 
  select b.acc, a.nls, a.kv, b.pdat,b.fdat, b.ostf, b.dos,b.kos, b.ostf-b.dos+b.kos
from saldob b , accounts a , tabval t
where (b.dos<>0 or b.kos<>0 or b.ostf<>0)
  and b.acc=a.acc  and a.kv<>980  and a.kv=t.kv  and
  ( a.nls = t.s0000
  OR t.s0000 is null and a.nls in (t.s3800,t.s3801)
  OR a.nls like '3800_000000000'
  Or a.nls like '6204%'
  );

PROMPT *** Create  grants  VESH ***
grant SELECT                                                                 on VESH            to BARSREADER_ROLE;
grant SELECT                                                                 on VESH            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VESH            to START1;
grant SELECT                                                                 on VESH            to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VESH.sql =========*** End *** =========
PROMPT ===================================================================================== 
