

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_ZV_K.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_ZV_K ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_ZV_K ("G001", "G002", "G003", "G004", "G005", "G006", "G007", "G008", "G009", "G010", "G011", "G012", "G013", "G014", "G015", "G016", "G017", "G018", "G019", "G020", "G021", "G022", "G023", "G024", "G025", "G026", "G027", "G028", "G029", "G030", "G031", "G032", "G033", "G034", "G035", "G036", "G037", "G038", "G039", "G040", "G041", "G042", "G043", "G044", "G045", "G046", "G047", "G048", "G049", "G050", "G051", "G052", "G053", "G054", "G055", "G056", "G057", "G058", "G059", "G060", "G061", "G062", "G063", "G064", "G065", "G066", "G067", "G068", "G069", "G070", "G071", "G072", "G073", "G074", "G075", "G076", "G077", "G078", "G079", "G080", "G081", "G082", "G083", "G084", "G085", "G086", "G087", "G088", "G089", "ID", "ISIN", "NBS_OLD", "KV", "REPO", "D_K", "PF_OLD", "EMI", "OKPO", "AUKCION", "DAT_K", "NM_PROD", "BV1", "CENA0", "KL1", "N1", "R1", "D1", "P1", "Z1", "S1", "CF008_019", "N2", "KL2", "KL_K2", "CENA_K2", "CF008_023", "DAT_K2", "NM_PROD2", "N2_P", "KL2_P", "CF008_028", "DAT_P2", "NM_POK", "CENA_P2", "R2", "S2", "TR1_31", "KL31", "N31", "R31", "D31", "P31", "S31", "Z31", "IR31", "DAT_PG", "CF008_042", "DAT_IR", "KOT31", "CF008_045", "DAT_KOT", "DAT_P4", "SUMB4", "NM_POK4", "KL_P4", "CENA_P4", "N4", "BV31", "PV31", "CF008_055", "CF008_056", "CF008_057", "CF008_058", "CF008_059", "CF008_060", "CF008_061", "CF008_062", "CF008_063", "DNK", "CF008_065", "CF008_066", "DAT_R", "NLS", "NMS", "REF", "REF2", "VID_R", "CENA_START", "IR", "OST_V", "FL", "USERID", "NLS_S", "D2", "P2", "S_D", "S_C", "NLS_P", "S_DP", "S_CP", "OST_I", "S_DK", "S_CK", "OST_P", "NLS_P1", "DAT_P", "S_DP_NEW", "S_CP_NEW", "PAP", "S_DK_NEW", "S_CK_NEW", "OST_PQ", "OST_VQ", "S_DQ", "S_CQ", "S_DKQ", "S_CKQ", "S_DPQ", "S_CPQ", "S_DPQ_NEW", "S_CPQ_NEW", "S_DKQ_NEW", "S_CKQ_NEW", "NBS_NEW", "PF_NEW", "OST_VT", "OST_V31", "CENA", "CENA4", "N0", "D0", "P0", "R0", "S0", "D4", "P4", "R4", "S4", "Z4", "KL0", "KL4", "DAT_4", "FRM") AS 
  (SELECT t."G001",t."G002",t."G003",t."G004",t."G005",t."G006",t."G007",t."G008",t."G009",t."G010",t."G011",t."G012",t."G013",t."G014",t."G015",t."G016",t."G017",t."G018",t."G019",t."G020",t."G021",t."G022",t."G023",t."G024",t."G025",t."G026",t."G027",t."G028",t."G029",t."G030",t."G031",t."G032",t."G033",t."G034",t."G035",t."G036",t."G037",t."G038",t."G039",t."G040",t."G041",t."G042",t."G043",t."G044",t."G045",t."G046",t."G047",t."G048",t."G049",t."G050",t."G051",t."G052",t."G053",t."G054",t."G055",t."G056",t."G057",t."G058",t."G059",t."G060",t."G061",t."G062",t."G063",t."G064",t."G065",t."G066",t."G067",t."G068",t."G069",t."G070",t."G071",t."G072",t."G073",t."G074",t."G075",t."G076",t."G077",t."G078",t."G079",t."G080",t."G081",t."G082",t."G083",t."G084",t."G085",t."G086",t."G087",t."G088",t."G089",t."ID",t."ISIN",t."NBS_OLD",t."KV",t."REPO",t."D_K",t."PF_OLD",t."EMI",t."OKPO",t."AUKCION",t."DAT_K",t."NM_PROD",t."BV1",t."CENA0",t."KL1",t."N1",t."R1",t."D1",t."P1",t."Z1",t."S1",t."CF008_019",t."N2",t."KL2",t."KL_K2",t."CENA_K2",t."CF008_023",t."DAT_K2",t."NM_PROD2",t."N2_P",t."KL2_P",t."CF008_028",t."DAT_P2",t."NM_POK",t."CENA_P2",t."R2",t."S2",t."TR1_31",t."KL31",t."N31",t."R31",t."D31",t."P31",t."S31",t."Z31",t."IR31",t."DAT_PG",t."CF008_042",t."DAT_IR",t."KOT31",t."CF008_045",t."DAT_KOT",t."DAT_P4",t."SUMB4",t."NM_POK4",t."KL_P4",t."CENA_P4",t."N4",t."BV31",t."PV31",t."CF008_055",t."CF008_056",t."CF008_057",t."CF008_058",t."CF008_059",t."CF008_060",t."CF008_061",t."CF008_062",t."CF008_063",t."DNK",t."CF008_065",t."CF008_066",t."DAT_R",t."NLS",t."NMS",t."REF",t."REF2",t."VID_R",t."CENA_START",t."IR",t."OST_V",t."FL",t."USERID",t."NLS_S",t."D2",t."P2",t."S_D",t."S_C",t."NLS_P",t."S_DP",t."S_CP",t."OST_I",t."S_DK",t."S_CK",t."OST_P",t."NLS_P1",t."DAT_P",t."S_DP_NEW",t."S_CP_NEW",t."PAP",t."S_DK_NEW",t."S_CK_NEW",t."OST_PQ",t."OST_VQ",t."S_DQ",t."S_CQ",t."S_DKQ",t."S_CKQ",t."S_DPQ",t."S_CPQ",t."S_DPQ_NEW",t."S_CPQ_NEW",t."S_DKQ_NEW",t."S_CKQ_NEW",t."NBS_NEW",t."PF_NEW",t."OST_VT",t."OST_V31",t."CENA",t."CENA4",t."N0",t."D0",t."P0",t."R0",t."S0",t."D4",t."P4",t."R4",t."S4",t."Z4",t."KL0",t."KL4",t."DAT_4",t."FRM" FROM tmp_cp_zv t
       where frm like '_k');

PROMPT *** Create  grants  V_CP_ZV7K ***
grant SELECT                                                                 on V_CP_ZV7K       to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_ZV7K       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_ZV7K       to START1;
grant SELECT                                                                 on V_CP_ZV7K       to UPLD;

PROMPT *** Create  grants  V_CP_ZV8K ***
grant SELECT                                                                 on V_CP_ZV8K       to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_ZV8K       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_ZV8K       to START1;
grant SELECT                                                                 on V_CP_ZV8K       to UPLD;

PROMPT *** Create  grants  V_CP_ZV9K ***
grant SELECT                                                                 on V_CP_ZV9K       to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_ZV9K       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_ZV9K       to START1;
grant SELECT                                                                 on V_CP_ZV9K       to UPLD;

PROMPT *** Create  grants  V_CP_ZV_K ***
grant SELECT                                                                 on V_CP_ZV_K       to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_ZV_K       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_ZV_K       to START1;
grant SELECT                                                                 on V_CP_ZV_K       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_ZV_K.sql =========*** End *** ====
PROMPT ===================================================================================== 
