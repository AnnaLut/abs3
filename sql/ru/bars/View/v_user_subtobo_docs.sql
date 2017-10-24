

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_SUBTOBO_DOCS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_SUBTOBO_DOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_SUBTOBO_DOCS ("COLOR1", "COLOR2", "VDAT", "REF", "TT", "NLSA", "NLSB", "MFOB", "NB_B", "S", "S_", "DK", "SK", "LCV1", "DIG1", "USERID", "CHK", "NAZN", "LCV2", "DIG2", "S2", "S2_", "ND", "NEXTVISAGRP", "KV", "KV2", "TOBO", "FLAGS", "DEAL_TAG", "DATD", "PDAT", "PRTY", "SOS", "NAM_B", "MFOA", "NB_A", "DATP", "VOB", "NAM_A", "BRANCH", "ID_A", "ID_B") AS 
  select "COLOR1","COLOR2","VDAT","REF","TT","NLSA","NLSB","MFOB","NB_B","S","S_","DK","SK","LCV1","DIG1","USERID","CHK","NAZN","LCV2","DIG2","S2","S2_","ND","NEXTVISAGRP","KV","KV2","TOBO","FLAGS","DEAL_TAG","DATD","PDAT","PRTY","SOS","NAM_B","MFOA","NB_A","DATP","VOB","NAM_A","BRANCH","ID_A","ID_B" from v_user_visa_docs where
  tobo like tobopack.gettobo() || '%';

PROMPT *** Create  grants  V_USER_SUBTOBO_DOCS ***
grant SELECT                                                                 on V_USER_SUBTOBO_DOCS to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USER_SUBTOBO_DOCS to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_USER_SUBTOBO_DOCS to WR_CHCKINNR_SUBTOBO;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_SUBTOBO_DOCS.sql =========*** En
PROMPT ===================================================================================== 
