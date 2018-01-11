

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_REP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_REP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_REP ("BRANCH", "TT", "VOB", "VDAT", "KV", "DK", "S", "SQ", "NAM_A", "NLSA", "MFOA", "NAM_B", "NLSB", "MFOB", "NAZN", "S2", "KV2", "SQ2", "ND", "CC_ID", "SDATE", "NMK") AS 
  select "BRANCH","TT","VOB","VDAT","KV","DK","S","SQ","NAM_A","NLSA","MFOA","NAM_B","NLSB","MFOB","NAZN","S2","KV2","SQ2","ND","CC_ID","SDATE","NMK" from tmp_cck_rep;

PROMPT *** Create  grants  V_CCK_REP ***
grant SELECT                                                                 on V_CCK_REP       to BARSREADER_ROLE;
grant SELECT                                                                 on V_CCK_REP       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_REP       to RCC_DEAL;
grant SELECT                                                                 on V_CCK_REP       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_REP.sql =========*** End *** ====
PROMPT ===================================================================================== 
