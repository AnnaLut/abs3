

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_W_LIM_ARC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_W_LIM_ARC ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_W_LIM_ARC ("ND", "FDAT", "LIM2V", "LIM2", "SUMG", "SUMP", "SUMK", "SUMO", "OTM", "MDAT", "OST", "TYPM") AS 
  SELECT ND, FDAT, (LIM2+SUMG)/100   LIM2v,  LIM2/100  LIM2,   SUMG/100  SUMG ,   (sumo-sumg-NVL(sumk,0))/100 SUMP,
                  NVL(SUMK,0)/100  SUMK ,  SUMO/100  SUMO,   OTM,  MDAT,        fost_h (acc, fdat) / 100    OST, typm
FROM CC_LIM_ARC a  WHERE mdat = (SELECT MAX (mdat) FROM CC_LIM_ARC WHERE nd = a.ND);

PROMPT *** Create  grants  CC_W_LIM_ARC ***
grant SELECT                                                                 on CC_W_LIM_ARC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_W_LIM_ARC    to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_W_LIM_ARC.sql =========*** End *** =
PROMPT ===================================================================================== 
