

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_23_351.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_23_351 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_23_351 ("FDAT", "RNK", "CUSTTYPE", "ACC", "KV", "NBS", "TIP", "NLS", "ND", "VIDD", "FIN", "FINP", "FINV", "VKR", "BV", "BVQ", "BV02", "BV02Q", "EAD", "EADQ", "IDF", "PD", "CR", "CRQ", "CR_LGD", "KOL", "FIN23", "CCF", "PAWN", "TIP_ZAL", "KPZ", "KL_351", "ZAL", "ZALQ", "ZAL_BV", "ZAL_BVQ", "LGD", "RZ", "TEXT", "NMK", "PRINSIDER", "COUNTRY", "ISE", "SDATE", "DATE_V", "WDATE", "S250", "ISTVAL", "RC", "RCQ", "FAKTOR", "K_FAKTOR", "K_DEFOLT", "DV", "FIN_KOR", "TIPA", "OVKR", "P_DEF", "OVD", "OPD", "REZ23", "REZQ23", "REZ39", "REZQ39") AS 
  select "FDAT","RNK","CUSTTYPE","ACC","KV","NBS","TIP","NLS","ND","VIDD","FIN","FINP","FINV","VKR","BV","BVQ","BV02","BV02Q","EAD","EADQ","IDF","PD","CR","CRQ","CR_LGD","KOL","FIN23","CCF","PAWN","TIP_ZAL","KPZ","KL_351","ZAL","ZALQ","ZAL_BV","ZAL_BVQ","LGD","RZ","TEXT","NMK","PRINSIDER","COUNTRY","ISE","SDATE","DATE_V","WDATE","S250","ISTVAL","RC","RCQ","FAKTOR","K_FAKTOR","K_DEFOLT","DV","FIN_KOR","TIPA","OVKR","P_DEF","OVD","OPD","REZ23","REZQ23","REZ39","REZQ39" from (select r.*,nvl(n.rez23,0) rez23,nvl(n.rezq23,0) rezq23,nvl(n.rez39,0) rez39,nvl(n.rezq39,0) rezq39 from rez_cr r,  nbu23_rez n
   where r.fdat=TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy') and r.fdat = n.fdat (+) and r.acc=n.acc (+)) ;

PROMPT *** Create  grants  V_23_351 ***
grant SELECT                                                                 on V_23_351        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_23_351        to RCC_DEAL;
grant SELECT                                                                 on V_23_351        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_23_351.sql =========*** End *** =====
PROMPT ===================================================================================== 
