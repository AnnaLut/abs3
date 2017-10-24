

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_M080.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_M080 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_M080 ("BRANCH", "ND", "CC_ID", "SDATE", "WDATE", "NMK", "FIN", "S080", "R080", "M080", "OTM") AS 
  select BRANCH, to_number(nd) ND, CC_ID, SDATE, vdat WDATE, NMK, tt FIN,
       nam_a S080,  nlsa R080, MFOA M080, dk
from TMP_CCK_REP where dk is null;

PROMPT *** Create  grants  V_M080 ***
grant SELECT,UPDATE                                                          on V_M080          to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_M080          to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_M080.sql =========*** End *** =======
PROMPT ===================================================================================== 
