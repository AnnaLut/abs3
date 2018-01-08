

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CRV_BACK_REFS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CRV_BACK_REFS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CRV_BACK_REFS ("BACK_REF", "FLG", "TODO", "REF", "DEAL_TAG", "TT", "VOB", "ND", "PDAT", "VDAT", "KV", "DK", "S", "SQ", "SK", "DATD", "DATP", "NAM_A", "NLSA", "MFOA", "NAM_B", "NLSB", "MFOB", "NAZN", "D_REC", "USERID", "ID_A", "ID_B", "ID_O", "SIGN", "SOS", "VP", "CHK", "S2", "KV2", "KVQ", "REFL", "PRTY", "CURRVISAGRP", "NEXTVISAGRP", "REF_A", "TOBO", "SIGNED", "RESPID", "BIS") AS 
  select c.back_ref, 'BACKDOC' flg, ' ' todo, p."REF",p."DEAL_TAG",p."TT",p."VOB",p."ND",p."PDAT",p."VDAT",p."KV",p."DK",p."S",p."SQ",p."SK",p."DATD",p."DATP",p."NAM_A",p."NLSA",p."MFOA",p."NAM_B",p."NLSB",p."MFOB",p."NAZN",p."D_REC",p."USERID",p."ID_A",p."ID_B",p."ID_O",p."SIGN",p."SOS",p."VP",p."CHK",p."S2",p."KV2",p."KVQ",p."REFL",p."PRTY",p."CURRVISAGRP",p."NEXTVISAGRP",p."REF_A",p."TOBO",p."SIGNED",p."RESPID",p."BIS" from crv_back_refs c, oper p
where c.back_ref=p.ref
union all
select c.back_ref, 'PAYMENT' flg, c.todo, p."REF",p."DEAL_TAG",p."TT",p."VOB",p."ND",p."PDAT",p."VDAT",p."KV",p."DK",p."S",p."SQ",p."SK",p."DATD",p."DATP",p."NAM_A",p."NLSA",p."MFOA",p."NAM_B",p."NLSB",p."MFOB",p."NAZN",p."D_REC",p."USERID",p."ID_A",p."ID_B",p."ID_O",p."SIGN",p."SOS",p."VP",p."CHK",p."S2",p."KV2",p."KVQ",p."REFL",p."PRTY",p."CURRVISAGRP",p."NEXTVISAGRP",p."REF_A",p."TOBO",p."SIGNED",p."RESPID",p."BIS" from crv_back_refs c, oper p
where c.payment_ref=p.ref(+);

PROMPT *** Create  grants  V_CRV_BACK_REFS ***
grant SELECT                                                                 on V_CRV_BACK_REFS to BARSREADER_ROLE;
grant SELECT                                                                 on V_CRV_BACK_REFS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CRV_BACK_REFS to START1;
grant SELECT                                                                 on V_CRV_BACK_REFS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CRV_BACK_REFS.sql =========*** End **
PROMPT ===================================================================================== 
