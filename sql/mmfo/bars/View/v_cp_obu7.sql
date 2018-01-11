

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_OBU7.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_OBU7 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_OBU7 ("ID", "ISIN", "NBS_OLD", "KV", "REPO", "D_K", "PF_OLD", "EMI", "OKPO", "AUKCION", "DAT_K", "NM_PROD", "BV1", "CENA0", "KL1", "N1", "R1", "D1", "P1", "Z1", "S1", "CF007_019", "N2", "KL2", "KL_K2", "CENA_K2", "CF007_023", "DAT_K2", "NM_PROD2", "N2_P", "KL2_P", "CF007_028", "DAT_P2", "NM_POK", "CENA_P2", "R2", "S2", "TR1_31", "KL31", "N31", "R31", "D31", "P31", "S31", "Z31", "IR31", "DAT_PG", "CF007_042", "DAT_IR", "KOT31", "CF007_045", "DAT_KOT", "DAT_P4", "SUMB4", "NM_POK4", "KL_P4", "CENA_P4", "N4", "BV31", "PV31", "CF007_055", "CF007_056", "CF007_057", "CF007_058", "CF007_059", "CF007_060", "CF007_061", "CF007_062", "CF007_063", "DNK", "CF007_065", "CF007_066", "DAT_R", "NLS", "NMS", "REF", "REF2", "VID_R", "CENA_START", "IR", "OST_V", "FL", "USERID", "NLS_S", "D2", "P2", "S_D", "S_C", "NLS_P", "S_DP", "S_CP", "OST_I", "S_DK", "S_CK", "OST_P", "NLS_P1", "DAT_P", "S_DP_NEW", "S_CP_NEW", "PAP", "S_DK_NEW", "S_CK_NEW", "OST_PQ", "OST_VQ", "S_DQ", "S_CQ", "S_DKQ", "S_CKQ", "S_DPQ", "S_CPQ", "S_DPQ_NEW", "S_CPQ_NEW", "S_DKQ_NEW", "S_CKQ_NEW", "NBS_NEW", "PF_NEW", "OST_VT", "OST_V31", "CENA", "CENA4", "N0", "D0", "P0", "R0", "S0", "D4", "P4", "R4", "S4", "Z4", "KL0", "KL4", "DAT_4") AS 
  (SELECT t."ID",t."ISIN",t."NBS_OLD",t."KV",t."REPO",t."D_K",t."PF_OLD",t."EMI",t."OKPO",t."AUKCION",t."DAT_K",t."NM_PROD",t."BV1",t."CENA0",t."KL1",t."N1",t."R1",t."D1",t."P1",t."Z1",t."S1",t."CF007_019",t."N2",t."KL2",t."KL_K2",t."CENA_K2",t."CF007_023",t."DAT_K2",t."NM_PROD2",t."N2_P",t."KL2_P",t."CF007_028",t."DAT_P2",t."NM_POK",t."CENA_P2",t."R2",t."S2",t."TR1_31",t."KL31",t."N31",t."R31",t."D31",t."P31",t."S31",t."Z31",t."IR31",t."DAT_PG",t."CF007_042",t."DAT_IR",t."KOT31",t."CF007_045",t."DAT_KOT",t."DAT_P4",t."SUMB4",t."NM_POK4",t."KL_P4",t."CENA_P4",t."N4",t."BV31",t."PV31",t."CF007_055",t."CF007_056",t."CF007_057",t."CF007_058",t."CF007_059",t."CF007_060",t."CF007_061",t."CF007_062",t."CF007_063",t."DNK",t."CF007_065",t."CF007_066",t."DAT_R",t."NLS",t."NMS",t."REF",t."REF2",t."VID_R",t."CENA_START",t."IR",t."OST_V",t."FL",t."USERID",t."NLS_S",t."D2",t."P2",t."S_D",t."S_C",t."NLS_P",t."S_DP",t."S_CP",t."OST_I",t."S_DK",t."S_CK",t."OST_P",t."NLS_P1",t."DAT_P",t."S_DP_NEW",t."S_CP_NEW",t."PAP",t."S_DK_NEW",t."S_CK_NEW",t."OST_PQ",t."OST_VQ",t."S_DQ",t."S_CQ",t."S_DKQ",t."S_CKQ",t."S_DPQ",t."S_CPQ",t."S_DPQ_NEW",t."S_CPQ_NEW",t."S_DKQ_NEW",t."S_CKQ_NEW",t."NBS_NEW",t."PF_NEW",t."OST_VT",t."OST_V31",t."CENA",t."CENA4",t."N0",t."D0",t."P0",t."R0",t."S0",t."D4",t."P4",t."R4",t."S4",t."Z4",t."KL0",t."KL4",t."DAT_4" FROM tmp_cp_obu7 t);

PROMPT *** Create  grants  V_CP_OBU7 ***
grant SELECT                                                                 on V_CP_OBU7       to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_OBU7       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_OBU7       to START1;
grant SELECT                                                                 on V_CP_OBU7       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_OBU7.sql =========*** End *** ====
PROMPT ===================================================================================== 
