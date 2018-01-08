

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SAL_NBS2.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view SAL_NBS2 ***

  CREATE OR REPLACE FORCE VIEW BARS.SAL_NBS2 ("KV", "FDAT", "DOS", "KOS", "OST", "NBS2", "TOBO") AS 
  select a.kv, b.fdat, decode(s.fdat,B.fdat,s.dos,0),
       decode(s.fdat,B.fdat,s.kos,0), s.ostf-s.dos+s.kos, a.nbs2, a.tobo
from accounts a, saldoa s, fdat B
where a.acc=s.acc and (a.acc,s.fdat) =
      (select c.acc,max(c.fdat) from saldoa c
       where a.acc=c.acc and c.fdat <= B.fdat
group by c.acc);

PROMPT *** Create  grants  SAL_NBS2 ***
grant SELECT                                                                 on SAL_NBS2        to BARSREADER_ROLE;
grant SELECT                                                                 on SAL_NBS2        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SAL_NBS2        to START1;
grant SELECT                                                                 on SAL_NBS2        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SAL_NBS2.sql =========*** End *** =====
PROMPT ===================================================================================== 
