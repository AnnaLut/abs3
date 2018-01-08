

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOCS_TOBO_OUT2.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOCS_TOBO_OUT2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOCS_TOBO_OUT2 ("REF", "TT", "USERID", "ND", "NLSA", "S", "S_", "LCV", "KV", "VDAT", "PDAT", "S2", "S2_", "LCV2", "KV2", "MFOB", "NLSB", "DK", "SK", "DATD", "NAZN", "TOBO", "SOS", "DEAL_TAG", "PRTY", "NAM_B", "MFOA", "DATP", "VOB") AS 
  select "REF","TT","USERID","ND","NLSA","S","S_","LCV","KV","VDAT","PDAT","S2","S2_","LCV2","KV2","MFOB","NLSB","DK","SK","DATD","NAZN","TOBO","SOS","DEAL_TAG","PRTY","NAM_B","MFOA","DATP","VOB" from v_docs_tobo 
 ;

PROMPT *** Create  grants  V_DOCS_TOBO_OUT2 ***
grant SELECT                                                                 on V_DOCS_TOBO_OUT2 to BARSREADER_ROLE;
grant SELECT                                                                 on V_DOCS_TOBO_OUT2 to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DOCS_TOBO_OUT2 to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOCS_TOBO_OUT2.sql =========*** End *
PROMPT ===================================================================================== 
