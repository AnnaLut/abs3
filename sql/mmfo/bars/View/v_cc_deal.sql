

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_DEAL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_DEAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_DEAL ("TIP", "VIDD", "RNK", "ND", "CC_ID", "SDATE", "WDATE", "BRANCH", "FIN23", "OBS23", "KAT23", "K23", "SOS", "PROD") AS 
  SELECT 'CCK' AS tip,
          c.vidd,
          c.rnk,
          c.nd,
          c.cc_id,
          c.sdate,
          c.wdate,
          c.branch,
          c.fin23,
          c.obs23,
          c.kat23,
          c.k23,
          c.sos,
          c.prod
     FROM cc_deal c;

PROMPT *** Create  grants  V_CC_DEAL ***
grant DELETE,SELECT,UPDATE                                                   on V_CC_DEAL       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_DEAL.sql =========*** End *** ====
PROMPT ===================================================================================== 
