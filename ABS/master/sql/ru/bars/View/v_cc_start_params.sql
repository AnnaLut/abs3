

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_START_PARAMS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_START_PARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_START_PARAMS ("BRANCH", "VIDD", "ND", "OKPO", "NMK", "CC_ID", "SDATE", "WDATE") AS 
  SELECT d.branch, d.vidd, d.nd, c.okpo, c.nmk, d.cc_id, d.sdate, d.wdate
     FROM cc_deal d, customer c
    WHERE d.rnk = c.rnk AND sos < 15 AND vidd IN (1, 2, 3, 11, 12, 13);

PROMPT *** Create  grants  V_CC_START_PARAMS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CC_START_PARAMS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CC_START_PARAMS to RCC_DEAL;
grant FLASHBACK,SELECT                                                       on V_CC_START_PARAMS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_START_PARAMS.sql =========*** End 
PROMPT ===================================================================================== 
