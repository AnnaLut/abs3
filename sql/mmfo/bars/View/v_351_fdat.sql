

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_351_FDAT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_351_FDAT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_351_FDAT ("FDAT", "RNK", "CUSTTYPE", "ACC", "KV", "NBS", "TIP", "NLS", "ND", "VIDD", "FIN", "FINP", "FINV", "VKR", "BV", "BVQ", "BV02", "BV02Q", "EAD", "EADQ", "IDF", "PD", "CR", "CRQ", "CR_LGD", "KOL", "FIN23", "CCF", "PAWN", "TIP_ZAL", "KPZ", "KL_351", "ZAL", "ZALQ", "ZAL_BV", "ZAL_BVQ", "LGD", "RZ", "TEXT", "NMK", "PRINSIDER", "COUNTRY", "ISE", "SDATE", "DATE_V", "WDATE", "S250", "ISTVAL", "RC", "RCQ", "FAKTOR", "K_FAKTOR", "K_DEFOLT", "DV", "FIN_KOR", "TIPA", "OVKR", "P_DEF", "OVD", "OPD", "KOL23", "KOL24", "KOL25", "KOL26", "KOL27", "KOL28", "KOL29", "FIN_Z", "PD_0", "CC_ID", "KOL17", "KOL31", "S180", "T4", "RPB", "GRP", "OB22", "KOL30", "S080", "S080_Z", "TIP_FIN", "DDD_6B", "KF") AS 
  select "FDAT","RNK","CUSTTYPE","ACC","KV","NBS","TIP","NLS","ND","VIDD","FIN","FINP","FINV","VKR","BV","BVQ","BV02","BV02Q","EAD","EADQ","IDF","PD","CR","CRQ","CR_LGD","KOL","FIN23","CCF","PAWN","TIP_ZAL","KPZ","KL_351","ZAL","ZALQ","ZAL_BV","ZAL_BVQ","LGD","RZ","TEXT","NMK","PRINSIDER","COUNTRY","ISE","SDATE","DATE_V","WDATE","S250","ISTVAL","RC","RCQ","FAKTOR","K_FAKTOR","K_DEFOLT","DV","FIN_KOR","TIPA","OVKR","P_DEF","OVD","OPD","KOL23","KOL24","KOL25","KOL26","KOL27","KOL28","KOL29","FIN_Z","PD_0","CC_ID","KOL17","KOL31","S180","T4","RPB","GRP","OB22","KOL30","S080","S080_Z","TIP_FIN","DDD_6B","KF" from REZ_CR
where fdat =  NVL (TO_DATE (pul.Get_Mas_Ini_Val ('sFdat1'),'dd-mm-yyyy'),trunc(gl.BD,'MM'));

PROMPT *** Create  grants  V_351_FDAT ***
grant SELECT                                                                 on V_351_FDAT      to BARSREADER_ROLE;
grant SELECT                                                                 on V_351_FDAT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_351_FDAT      to START1;
grant SELECT                                                                 on V_351_FDAT      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_351_FDAT.sql =========*** End *** ===
PROMPT ===================================================================================== 
