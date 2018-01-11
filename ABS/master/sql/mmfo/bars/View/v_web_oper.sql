

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WEB_OPER.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WEB_OPER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WEB_OPER ("REF", "DEAL_TAG", "TT", "VOB", "ND", "PDAT", "VDAT", "KV", "DK", "S", "SQ", "SK", "DATD", "DATP", "NAM_A", "NLSA", "MFOA", "NAM_B", "NLSB", "MFOB", "NAZN", "D_REC", "USERID", "ID_A", "ID_B", "ID_O", "SIGN", "SOS", "VP", "CHK", "S2", "KV2", "KVQ", "REFL", "PRTY", "SQ2", "CURRVISAGRP", "NEXTVISAGRP", "REF_A", "TOBO", "SIGNED") AS 
  SELECT "REF","DEAL_TAG","TT","VOB","ND","PDAT","VDAT","KV","DK","S","SQ","SK","DATD","DATP","NAM_A","NLSA","MFOA","NAM_B","NLSB","MFOB","NAZN","D_REC","USERID","ID_A","ID_B","ID_O","SIGN","SOS","VP","CHK","S2","KV2","KVQ","REFL","PRTY","SQ2","CURRVISAGRP","NEXTVISAGRP","REF_A","TOBO","SIGNED"
FROM OPER
;

PROMPT *** Create  grants  V_WEB_OPER ***
grant SELECT                                                                 on V_WEB_OPER      to BARSREADER_ROLE;
grant SELECT                                                                 on V_WEB_OPER      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WEB_OPER      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_WEB_OPER      to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_WEB_OPER      to WR_DOCVIEW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WEB_OPER.sql =========*** End *** ===
PROMPT ===================================================================================== 
