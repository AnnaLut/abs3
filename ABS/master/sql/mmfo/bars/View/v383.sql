

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V383.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V383 ***

  CREATE OR REPLACE FORCE VIEW BARS.V383 ("ACC", "NLS", "FDAT", "PDAT", "OSTF", "DOS", "KOS", "TRCN") AS 
  select s.acc,a.nls,s.fdat,s.pdat,s.ostf,s.dos,s.kos,s.trcn
 from saldoa s,accounts a where a.acc=s.acc and s.acc in (select acc from t383);

PROMPT *** Create  grants  V383 ***
grant SELECT                                                                 on V383            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V383            to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V383.sql =========*** End *** =========
PROMPT ===================================================================================== 
