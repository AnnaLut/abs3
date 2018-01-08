

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V392.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V392 ***

  CREATE OR REPLACE FORCE VIEW BARS.V392 ("ACC", "NLS", "FDAT", "PDAT", "OSTF", "DOS", "KOS", "TRCN") AS 
  select s.acc,a.nls,s.fdat,s.pdat,s.ostf,s.dos,s.kos,s.trcn
 from saldoa s,accounts a where a.acc=s.acc and s.acc in (select acc from t392);

PROMPT *** Create  grants  V392 ***
grant SELECT                                                                 on V392            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V392            to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V392.sql =========*** End *** =========
PROMPT ===================================================================================== 
