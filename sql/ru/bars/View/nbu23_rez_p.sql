

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_REZ_P.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_REZ_P ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_REZ_P ("FDAT", "ID", "RNK", "NBS", "KV", "ND", "CC_ID", "ACC", "NLS", "BRANCH", "FIN", "OBS", "KAT", "K", "IRR", "ZAL", "BV", "PV", "REZ", "REZQ", "DD", "DDD", "BVQ", "CUSTTYPE", "IDR", "WDATE", "OKPO", "NMK", "RZ", "PAWN", "ISTVAL", "R013", "REZN", "REZNQ", "ARJK", "REZD", "PVZ", "PVZQ", "ZALQ", "ZPR", "ZPRQ", "PVQ", "RU", "INN", "NRC", "SDATE", "IR", "S031", "K040", "PROD", "K110", "K070", "K051", "S260", "R011", "R012", "S240", "S180", "S580", "NLS_REZ", "NLS_REZN", "S250", "ACC_REZ", "FIN_R", "DISKONT", "ISP", "OB22", "TIP", "SPEC", "ZAL_BL", "S280_290", "ZAL_BLQ", "ACC_REZN", "OB22_REZ", "OB22_REZN", "IR0", "IRR0", "ND_CP", "SUM_IMP", "SUMQ_IMP", "PV_ZAL", "VKR", "S_L", "SQ_L", "ZAL_SV", "ZAL_SVQ", "GRP", "KOL_SP", "REZ39", "PVP", "BV_30", "BVQ_30", "REZ_30", "REZQ_30", "NLS_REZ_30", "ACC_REZ_30", "OB22_REZ_30", "BV_0", "BVQ_0", "REZ_0", "REZQ_0", "NLS_REZ_0", "ACC_REZ_0", "OB22_REZ_0", "KAT39", "REZQ39", "S250_39", "REZ23", "REZQ23", "KAT23", "S250_23", "DAT_MI", "TIPA", "BVUQ", "BVU", "EAD", "EADQ", "CR", "CRQ", "FIN_351", "KOL_351", "KPZ", "KL_351", "LGD", "OVKR", "P_DEF", "OVD", "OPD", "ZAL_351", "ZALQ_351", "RC", "RCQ", "CCF", "TIP_351", "PD_0", "FIN_Z", "ISTVAL_351", "RPB", "S080", "S080_Z", "DDD_6B", "FIN_P", "FIN_D", "Z", "PD") AS 
  select "FDAT","ID","RNK","NBS","KV","ND","CC_ID","ACC","NLS","BRANCH","FIN","OBS","KAT","K","IRR","ZAL","BV","PV","REZ","REZQ","DD","DDD","BVQ","CUSTTYPE","IDR","WDATE","OKPO","NMK","RZ","PAWN","ISTVAL","R013","REZN","REZNQ","ARJK","REZD","PVZ","PVZQ","ZALQ","ZPR","ZPRQ","PVQ","RU","INN","NRC","SDATE","IR","S031","K040","PROD","K110","K070","K051","S260","R011","R012","S240","S180","S580","NLS_REZ","NLS_REZN","S250","ACC_REZ","FIN_R","DISKONT","ISP","OB22","TIP","SPEC","ZAL_BL","S280_290","ZAL_BLQ","ACC_REZN","OB22_REZ","OB22_REZN","IR0","IRR0","ND_CP","SUM_IMP","SUMQ_IMP","PV_ZAL","VKR","S_L","SQ_L","ZAL_SV","ZAL_SVQ","GRP","KOL_SP","REZ39","PVP","BV_30","BVQ_30","REZ_30","REZQ_30","NLS_REZ_30","ACC_REZ_30","OB22_REZ_30","BV_0","BVQ_0","REZ_0","REZQ_0","NLS_REZ_0","ACC_REZ_0","OB22_REZ_0","KAT39","REZQ39","S250_39","REZ23","REZQ23","KAT23","S250_23","DAT_MI","TIPA","BVUQ","BVU","EAD","EADQ","CR","CRQ","FIN_351","KOL_351","KPZ","KL_351","LGD","OVKR","P_DEF","OVD","OPD","ZAL_351","ZALQ_351","RC","RCQ","CCF","TIP_351","PD_0","FIN_Z","ISTVAL_351","RPB","S080","S080_Z","DDD_6B","FIN_P","FIN_D","Z","PD" from nbu23_REZ where fdat  = TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy');

PROMPT *** Create  grants  NBU23_REZ_P ***
grant SELECT                                                                 on NBU23_REZ_P     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBU23_REZ_P     to RCC_DEAL;
grant SELECT                                                                 on NBU23_REZ_P     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_REZ_P.sql =========*** End *** ==
PROMPT ===================================================================================== 
