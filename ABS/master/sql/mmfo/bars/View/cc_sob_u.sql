

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_SOB_U.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_SOB_U ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_SOB_U ("ND", "FDAT", "ID", "ISP", "TXT", "OTM", "FREQ", "PSYS", "KF", "FACT_DATE") AS 
  SELECT "ND","FDAT","ID","ISP","TXT","OTM","FREQ","PSYS","KF","FACT_DATE"
     FROM bars.CC_SOB
    WHERE psys is not null;

PROMPT *** Create  grants  CC_SOB_U ***
grant SELECT                                                                 on CC_SOB_U        to BARSREADER_ROLE;
grant SELECT                                                                 on CC_SOB_U        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_SOB_U        to START1;
grant SELECT                                                                 on CC_SOB_U        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_SOB_U.sql =========*** End *** =====
PROMPT ===================================================================================== 
