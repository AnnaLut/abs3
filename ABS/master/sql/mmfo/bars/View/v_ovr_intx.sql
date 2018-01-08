

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OVR_INTX.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OVR_INTX ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OVR_INTX ("NPP", "CDAT", "ACC8", "ACC", "IP8", "IA8", "IP2", "IA2", "RNK", "VN", "AKT8", "PAS8", "S2", "S8", "PR2", "PR8", "PR", "SAL8", "OST2", "KP", "KA") AS 
  select npp, cdat, acc8, acc,  IP8,  IA8 , IP2,    IA2,  rnk, vn,
        Akt8/100 AKT8 ,         Pas8/100 PAS8,
  round(S2,0)/100 S2  ,  round(S8,0)/100 S8  ,
 round(PR2,0)/100 PR2 , round(PR8,0)/100 PR8 , round(PR,0)/100 PR ,
         sal8/100 SAL8,         Ost2/100 ost2,
       round(KP,4) KP ,      round(KA,4) KA
from  bars.OVR_INTX  ;

PROMPT *** Create  grants  V_OVR_INTX ***
grant SELECT                                                                 on V_OVR_INTX      to BARSREADER_ROLE;
grant SELECT                                                                 on V_OVR_INTX      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OVR_INTX      to START1;
grant SELECT                                                                 on V_OVR_INTX      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OVR_INTX.sql =========*** End *** ===
PROMPT ===================================================================================== 
