

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TARIF_RKO.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TARIF_RKO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TARIF_RKO ("NLS", "KV", "BRANCH", "RNK", "TAR13", "TAR14", "TAR15", "TAR16", "TAR17", "TAR32", "NMS") AS 
  Select NLS,KV,BRANCH,RNK,
 f_tarif(13,KV,NLS,10000) tar13,
 f_tarif(14,KV,NLS,10000) tar14,
 f_tarif(15,KV,NLS,10000) tar15,
 f_tarif(16,KV,NLS,10000) tar16,
 f_tarif(17,KV,NLS,10000) tar17,
 f_tarif(32,KV,NLS,10000)/100 tar32,
 NMS
from  Accounts
where NBS in ('2560','2565','2600','2603','2604','2650') and KV=980
      and DAZS is NULL;

PROMPT *** Create  grants  V_TARIF_RKO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_TARIF_RKO     to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TARIF_RKO     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TARIF_RKO     to START1;
grant FLASHBACK,SELECT                                                       on V_TARIF_RKO     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TARIF_RKO.sql =========*** End *** ==
PROMPT ===================================================================================== 
