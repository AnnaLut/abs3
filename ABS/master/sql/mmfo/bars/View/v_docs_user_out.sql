

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOCS_USER_OUT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOCS_USER_OUT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOCS_USER_OUT ("REF", "DEAL_TAG", "TT", "VOB", "ND", "PDAT", "VDAT", "KV", "DK", "S", "SQ", "SK", "DATD", "DATP", "NAM_A", "NLSA", "MFOA", "NAM_B", "NLSB", "MFOB", "NAZN", "D_REC", "ID_A", "ID_B", "ID_O", "SIGN", "SOS", "VP", "CHK", "S2", "KV2", "KVQ", "REFL", "PRTY", "SQ2", "CURRVISAGRP", "NEXTVISAGRP", "REF_A", "TOBO", "OTM", "SIGNED", "BRANCH", "USERID", "RESPID", "KF", "BIS", "S_", "LCV", "S2_", "LCV2") AS 
  SELECT 	op."REF",op."DEAL_TAG",op."TT",op."VOB",op."ND",op."PDAT",op."VDAT",op."KV",op."DK",op."S",op."SQ",op."SK",op."DATD",op."DATP",op."NAM_A",op."NLSA",op."MFOA",op."NAM_B",op."NLSB",op."MFOB",op."NAZN",op."D_REC",op."ID_A",op."ID_B",op."ID_O",op."SIGN",op."SOS",op."VP",op."CHK",op."S2",op."KV2",op."KVQ",op."REFL",op."PRTY",op."SQ2",op."CURRVISAGRP",op."NEXTVISAGRP",op."REF_A",op."TOBO",op."OTM",op."SIGNED",op."BRANCH",op."USERID",op."RESPID",op."KF",op."BIS", op.S/t1.denom as S_, t1.LCV as LCV, op.S2/t2.denom as S2_, t2.LCV as LCV2
FROM OPER op, TABVAL t1, TABVAL t2
WHERE t1.KV = op.KV and t2.KV = op.KV2 and op.USERID = getcurrentuserid;

PROMPT *** Create  grants  V_DOCS_USER_OUT ***
grant SELECT                                                                 on V_DOCS_USER_OUT to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DOCS_USER_OUT to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_DOCS_USER_OUT to WR_DOCLIST_USER;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOCS_USER_OUT.sql =========*** End **
PROMPT ===================================================================================== 
