

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_VB_GPK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_VB_GPK ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_VB_GPK ("ND", "FDAT", "VX", "GK", "GP", "GO", "IX") AS 
  select l.nd,
       l.fdat,
      (l.lim2+ p.sumg)/100,
       p.sumg/100,
      (p.sumo-p.sumg)/100,
       p.sumo/100,
       l.lim2/100
from cc_lim l, cc_lim p
where l.nd=p.nd and l.fdat=p.fdat;

PROMPT *** Create  grants  CC_VB_GPK ***
grant SELECT                                                                 on CC_VB_GPK       to BARSREADER_ROLE;
grant SELECT                                                                 on CC_VB_GPK       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_VB_GPK       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_VB_GPK       to WR_ALL_RIGHTS;
grant SELECT                                                                 on CC_VB_GPK       to WR_CREDIT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_VB_GPK.sql =========*** End *** ====
PROMPT ===================================================================================== 
