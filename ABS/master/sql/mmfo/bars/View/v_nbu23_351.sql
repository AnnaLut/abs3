

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU23_351.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU23_351 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBU23_351 ("FDAT", "ID", "RNK", "NBS", "KV", "ND", "CC_ID", "ACC", "NLS", "BRANCH", "FIN", "OBS", "KAT", "K", "IRR", "ZAL", "ZALQ", "S180", "BV", "BVQ", "PV", "PVQ", "REZ", "REZQ", "DD", "DDD", "CUSTTYPE", "IDR", "WDATE", "OKPO", "NMK", "RZ", "ISTVAL", "R013", "PVZ", "PVZQ", "SDATE", "R011", "S250", "FIN_R", "DISKONT", "ISP", "OB22", "SPEC", "ZAL_BL", "ZAL_BLQ", "SUM_IMP", "SUMQ_IMP", "ZAL_SV", "ZAL_SVQ", "GRP", "KOL_SP", "PVP", "REZ39", "REZQ39", "REZ23", "REZQ23", "KAT23", "S250_23", "TIPA", "EAD", "EADQ", "CR", "CRQ", "KOL_351", "FIN_351", "VKR", "KL_351", "LGD", "OVKR", "P_DEF", "OVD", "OPD", "CCF", "FIN_Z") AS 
  select "FDAT","ID","RNK","NBS","KV","ND","CC_ID","ACC","NLS","BRANCH","FIN","OBS","KAT","K","IRR","ZAL","ZALQ","S180","BV","BVQ","PV","PVQ","REZ","REZQ","DD","DDD","CUSTTYPE","IDR","WDATE","OKPO","NMK","RZ","ISTVAL","R013","PVZ","PVZQ","SDATE","R011","S250","FIN_R","DISKONT","ISP","OB22","SPEC","ZAL_BL","ZAL_BLQ","SUM_IMP","SUMQ_IMP","ZAL_SV","ZAL_SVQ","GRP","KOL_SP","PVP","REZ39","REZQ39","REZ23","REZQ23","KAT23","S250_23","TIPA","EAD","EADQ","CR","CRQ","KOL_351","FIN_351","VKR","KL_351","LGD","OVKR","P_DEF","OVD","OPD","CCF","FIN_Z"
   from (select  FDAT   , ID     , RNK     , NBS   , KV     , ND     , CC_ID , ACC   , NLS  , BRANCH, FIN    , OBS     , KAT  , K      , IRR   ,
                 ZAL    , zalq   , s180    , BV    , BVQ    , PV     , PVQ   , REZ   , REZQ , DD    , DDD    , CUSTTYPE, IDR  , WDATE  , OKPO  ,
                 NMK    , RZ     , ISTVAL  , R013  , PVZ    , PVZQ   , SDATE , R011  , S250 , FIN_R , DISKONT, ISP     , OB22 , SPEC   , ZAL_BL,
                 ZAL_BLQ, SUM_IMP, SUMQ_IMP, ZAL_SV, ZAL_SVQ, GRP    , KOL_SP, PVP   , REZ39, REZQ39, REZ23  , REZQ23  , KAT23, S250_23, TIPA  ,
                 EAD    , EADQ   , CR      , CRQ   , KOL_351, FIN_351, VKR   , KL_351, LGD  , OVKR  , P_DEF  , OVD     , OPD  , CCF    , FIN_Z
         from    nbu23_rez
         where   fdat=TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'));

PROMPT *** Create  grants  V_NBU23_351 ***
grant SELECT                                                                 on V_NBU23_351     to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBU23_351     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBU23_351     to RCC_DEAL;
grant SELECT                                                                 on V_NBU23_351     to START1;
grant SELECT                                                                 on V_NBU23_351     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU23_351.sql =========*** End *** ==
PROMPT ===================================================================================== 
