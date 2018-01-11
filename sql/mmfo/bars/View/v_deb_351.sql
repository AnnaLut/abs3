

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DEB_351.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DEB_351 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DEB_351 ("FDAT", "RNK", "CUSTTYPE", "ACC", "KV", "NBS", "TIP", "NLS", "ND", "VIDD", "FIN", "FINP", "FINV", "VKR", "BV", "BVQ", "BV02", "BV02Q", "EAD", "EADQ", "IDF", "PD", "CR", "CRQ", "CR_LGD", "KOL", "FIN23", "CCF", "PAWN", "TIP_ZAL", "KPZ", "KL_351", "ZAL", "ZALQ", "ZAL_BV", "ZAL_BVQ", "LGD", "RZ", "TEXT", "NMK", "PRINSIDER", "COUNTRY", "ISE", "SDATE", "DATE_V", "WDATE", "S250", "ISTVAL", "RC", "RCQ", "FAKTOR", "K_FAKTOR", "K_DEFOLT", "DV", "FIN_KOR", "TIPA", "OVKR", "P_DEF", "OVD", "OPD", "KOL23", "KOL24", "KOL25", "KOL26", "KOL27", "KOL28", "KOL29", "FIN_Z", "PD_0", "CC_ID", "KOL17", "KOL31", "S180", "T4", "RPB", "GRP", "OB22", "KOL30", "S080", "S080_Z", "TIP_FIN", "DDD_6B", "KF", "LGD_LONG", "Z", "FIN_KOL", "RNK_SK", "FIN_SK", "FIN_PK") AS 
  select r."FDAT",r."RNK",r."CUSTTYPE",r."ACC",r."KV",r."NBS",r."TIP",r."NLS",r."ND",r."VIDD",r."FIN",r."FINP",r."FINV",r."VKR",r."BV",r."BVQ",r."BV02",r."BV02Q",r."EAD",r."EADQ",r."IDF",r."PD",r."CR",r."CRQ",r."CR_LGD",r."KOL",r."FIN23",r."CCF",r."PAWN",r."TIP_ZAL",r."KPZ",r."KL_351",r."ZAL",r."ZALQ",r."ZAL_BV",r."ZAL_BVQ",r."LGD",r."RZ",r."TEXT",r."NMK",r."PRINSIDER",r."COUNTRY",r."ISE",r."SDATE",r."DATE_V",r."WDATE",r."S250",r."ISTVAL",r."RC",r."RCQ",r."FAKTOR",r."K_FAKTOR",r."K_DEFOLT",r."DV",r."FIN_KOR",r."TIPA",r."OVKR",r."P_DEF",r."OVD",r."OPD",r."KOL23",r."KOL24",r."KOL25",r."KOL26",r."KOL27",r."KOL28",r."KOL29",r."FIN_Z",r."PD_0",r."CC_ID",r."KOL17",r."KOL31",r."S180",r."T4",r."RPB",r."GRP",r."OB22",r."KOL30",r."S080",r."S080_Z",r."TIP_FIN",r."DDD_6B",r."KF",r."LGD_LONG",r."Z",r."FIN_KOL",r."RNK_SK",r."FIN_SK",r."FIN_PK" from  rez_cr r, rez_deb d
   where  r.fdat=TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy') and d.nbs = r.nbs and d.deb in (1,2);

PROMPT *** Create  grants  V_DEB_351 ***
grant SELECT                                                                 on V_DEB_351       to BARSREADER_ROLE;
grant SELECT                                                                 on V_DEB_351       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DEB_351       to RCC_DEAL;
grant SELECT                                                                 on V_DEB_351       to START1;
grant SELECT                                                                 on V_DEB_351       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DEB_351.sql =========*** End *** ====
PROMPT ===================================================================================== 
