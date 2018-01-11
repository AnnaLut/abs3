

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_1.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_1 ("FDAT", "ID", "RNK", "NBS", "KV", "ND", "CC_ID", "ACC", "NLS", "BRANCH", "FIN", "OBS", "KAT", "K", "IRR", "ZAL", "BV", "PV", "REZ", "REZQ", "DD", "DDD", "BVQ", "CUSTTYPE", "IDR", "WDATE", "OKPO", "NMK", "RZ", "PAWN", "ISTVAL", "R013", "REZN", "REZNQ", "ARJK", "PVZ", "PVZQ", "ZALQ", "ZPR", "ZPRQ", "PVQ", "RU", "INN", "NRC", "SDATE", "IR", "S031", "K040", "PROD", "K110", "K070", "K051", "S260", "R011", "R012", "S240", "S180", "S580", "NLS_REZ", "NLS_REZN", "S250", "ACC_REZ", "FIN_R", "DISKONT", "ISP", "OB22", "TIP", "SPEC", "ZAL_BL", "S280_290", "ZAL_BLQ", "REZD", "ACC_REZN", "OB22_REZ", "OB22_REZN", "IR0", "IRR0", "ND_CP", "SUM_IMP", "SUMQ_IMP", "PV_ZAL", "VKR", "S_L", "SQ_L") AS 
  (select n."FDAT",n."ID",n."RNK",n."NBS",n."KV",n."ND",n."CC_ID",n."ACC",n."NLS",n."BRANCH",n."FIN",n."OBS",n."KAT",n."K",n."IRR",n."ZAL",n."BV",n."PV",n."REZ",n."REZQ",n."DD",n."DDD",n."BVQ",n."CUSTTYPE",n."IDR",n."WDATE",n."OKPO",n."NMK",n."RZ",n."PAWN",n."ISTVAL",n."R013",n."REZN",n."REZNQ",n."ARJK",n."PVZ",n."PVZQ",n."ZALQ",n."ZPR",n."ZPRQ",n."PVQ",n."RU",n."INN",n."NRC",n."SDATE",n."IR",n."S031",n."K040",n."PROD",n."K110",n."K070",n."K051",n."S260",n."R011",n."R012",n."S240",n."S180",n."S580",n."NLS_REZ",n."NLS_REZN",n."S250",n."ACC_REZ",n."FIN_R",n."DISKONT",n."ISP",n."OB22",n."TIP",n."SPEC",n."ZAL_BL",n."S280_290",n."ZAL_BLQ",n."REZD",n."ACC_REZN",n."OB22_REZ",n."OB22_REZN",n."IR0",n."IRR0",n."ND_CP",n."SUM_IMP",n."SUMQ_IMP",n."PV_ZAL",n."VKR",n."S_L",n."SQ_L" from nbu23_rez n, V_SFDAT v
 where  n.fdat=v.b and n.id like 'CCK2%' and n.kv<>980);

PROMPT *** Create  grants  V_1 ***
grant SELECT                                                                 on V_1             to BARSREADER_ROLE;
grant SELECT                                                                 on V_1             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_1             to START1;
grant SELECT                                                                 on V_1             to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_1.sql =========*** End *** ==========
PROMPT ===================================================================================== 
