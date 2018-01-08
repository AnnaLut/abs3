

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOCS_TOBO_IN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOCS_TOBO_IN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOCS_TOBO_IN ("REF", "DEAL_TAG", "TT", "VOB", "ND", "PDAT", "VDAT", "KV", "DK", "S", "SQ", "SK", "DATD", "DATP", "NAM_A", "NLSA", "MFOA", "NAM_B", "NLSB", "MFOB", "NAZN", "D_REC", "ID_A", "ID_B", "ID_O", "SIGN", "SOS", "VP", "CHK", "S2", "KV2", "KVQ", "REFL", "PRTY", "SQ2", "CURRVISAGRP", "NEXTVISAGRP", "REF_A", "TOBO", "OTM", "SIGNED", "BRANCH", "USERID", "RESPID", "KF", "BIS", "S_", "LCV", "S2_", "LCV2") AS 
  select op."REF",op."DEAL_TAG",op."TT",op."VOB",op."ND",op."PDAT",op."VDAT",op."KV",op."DK",op."S",op."SQ",op."SK",op."DATD",op."DATP",op."NAM_A",op."NLSA",op."MFOA",op."NAM_B",op."NLSB",op."MFOB",op."NAZN",op."D_REC",op."ID_A",op."ID_B",op."ID_O",op."SIGN",op."SOS",op."VP",op."CHK",op."S2",op."KV2",op."KVQ",op."REFL",op."PRTY",op."SQ2",op."CURRVISAGRP",op."NEXTVISAGRP",op."REF_A",op."TOBO",op."OTM",op."SIGNED",op."BRANCH",op."USERID",op."RESPID",op."KF",op."BIS", op.s/t1.denom as s_, t1.lcv as lcv, op.s2/t1.denom as s2_, t2.lcv as lcv2
from oper op, tabval$global t1, tabval$global t2
where     t1.kv = op.kv and t2.kv = op.kv2
    and op.mfob = to_char(f_ourmfo)
    and (op.nlsb, nvl(op.kv2,op.kv)) in
        (select a.nls, a.kv
        from accounts a
        where a.branch like SYS_CONTEXT ('bars_context', 'user_branch_mask'))
;

PROMPT *** Create  grants  V_DOCS_TOBO_IN ***
grant SELECT                                                                 on V_DOCS_TOBO_IN  to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DOCS_TOBO_IN  to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_DOCS_TOBO_IN  to WR_DOCLIST_TOBO;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOCS_TOBO_IN.sql =========*** End ***
PROMPT ===================================================================================== 
