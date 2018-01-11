

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ANI_GAPV1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view ANI_GAPV1 ***

  CREATE OR REPLACE FORCE VIEW BARS.ANI_GAPV1 ("FDAT", "YN") AS 
  select r.FDAT, (select 1 from ani_gap where fdat=r.FDAT and rownum=1) YN
from (SELECT distinct fdat from rnbu_trace1) r;

PROMPT *** Create  grants  ANI_GAPV1 ***
grant SELECT                                                                 on ANI_GAPV1       to BARSREADER_ROLE;
grant SELECT                                                                 on ANI_GAPV1       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANI_GAPV1       to SALGL;
grant SELECT                                                                 on ANI_GAPV1       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ANI_GAPV1.sql =========*** End *** ====
PROMPT ===================================================================================== 
