

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VESHZ.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view VESHZ ***

  CREATE OR REPLACE FORCE VIEW BARS.VESHZ ("FDAT", "NLS", "PRZ", "ISX") AS 
  select b.fdat,a.nls, sign(b.ostf-b.dos+b.kos), sum(b.ostf-b.dos+b.kos)
   from saldob b, accounts a
   where b.acc=a.acc and a.nls like '3800_000000000' and a.kv<>980
   group by b.fdat,a.nls,sign(b.ostf-b.dos+b.kos)
union all
select b.fdat,a.nls, sign(b.ostf-b.dos+b.kos), (b.ostf-b.dos+b.kos)
   from saldoa b, accounts a
   where b.acc=a.acc and a.nls like '3801_00000000_' and a.kv=980;

PROMPT *** Create  grants  VESHZ ***
grant SELECT                                                                 on VESHZ           to BARSREADER_ROLE;
grant SELECT                                                                 on VESHZ           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VESHZ           to START1;
grant SELECT                                                                 on VESHZ           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VESHZ.sql =========*** End *** ========
PROMPT ===================================================================================== 
