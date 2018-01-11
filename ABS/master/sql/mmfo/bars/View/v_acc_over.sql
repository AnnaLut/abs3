

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACC_OVER.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACC_OVER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACC_OVER ("ACC", "ACCO", "TIPO", "FLAG", "ND", "DAY", "SOS", "DATD", "SD", "NDOC", "VIDD", "DATD2", "KRL", "USEOSTF", "USELIM", "ACC_9129", "ACC_8000", "OBS", "TXT", "USERID", "DELETED", "PR_2600A", "PR_KOMIS", "PR_9129", "PR_2069", "ACC_2067", "ACC_2069", "ACC_2096", "KF", "BRANCH") AS 
  select v."ACC",v."ACCO",v."TIPO",v."FLAG",v."ND",v."DAY",v."SOS",v."DATD",v."SD",v."NDOC",v."VIDD",v."DATD2",v."KRL",v."USEOSTF",v."USELIM",v."ACC_9129",v."ACC_8000",v."OBS",v."TXT",v."USERID",v."DELETED",v."PR_2600A",v."PR_KOMIS",v."PR_9129",v."PR_2069",v."ACC_2067",v."ACC_2069",v."ACC_2096",v."KF"
         , a.branch
from acc_over v
    , accounts a where v.acc=a.acc
 ;

PROMPT *** Create  grants  V_ACC_OVER ***
grant SELECT                                                                 on V_ACC_OVER      to BARSREADER_ROLE;
grant SELECT                                                                 on V_ACC_OVER      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ACC_OVER      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACC_OVER.sql =========*** End *** ===
PROMPT ===================================================================================== 
