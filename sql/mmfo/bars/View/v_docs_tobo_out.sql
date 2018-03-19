CREATE OR REPLACE VIEW V_DOCS_TOBO_OUT AS
SELECT op."REF",op."DEAL_TAG",op."TT",op."VOB",op."ND",op."PDAT",op."VDAT",op."ODAT",op."KV",op."DK",op."S",op."SQ",op."SK",op."DATD",op."DATP",op."NAM_A",op."NLSA",op."MFOA",op."NAM_B",op."NLSB",op."MFOB",op."NAZN",op."D_REC",op."ID_A",op."ID_B",op."ID_O",op."SIGN",op."SOS",op."VP",op."CHK",op."S2",op."KV2",op."KVQ",op."REFL",op."PRTY",op."SQ2",op."CURRVISAGRP",op."NEXTVISAGRP",op."REF_A",op."TOBO",op."OTM",op."SIGNED",op."BRANCH",op."USERID",op."RESPID",op."KF",op."BIS", op.s / t1.denom as s_, t1.lcv, op.s2 / t2.denom s2_, t2.lcv lcv2
     FROM oper op, tabval$global t1, tabval$global t2
    WHERE t1.kv = op.kv
      AND t2.kv = op.kv2
      AND op.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask');
