

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TARIF_RKO.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TARIF_RKO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TARIF_RKO ("NLS", "KV", "BRANCH", "RNK", "TAR13", "TAR14", "TAR15", "TAR16", "TAR17", "TAR113", "TAR114", "TAR115", "TAR116", "TAR117", "TAR118", "TAR32", "NMS") AS 
  SELECT NLS,
          KV,
          BRANCH,
          RNK,
          f_tarif (13,
                   KV,
                   NLS,
                   10000)
             tar13,
          f_tarif (14,
                   KV,
                   NLS,
                   10000)
             tar14,
          f_tarif (15,
                   KV,
                   NLS,
                   10000)
             tar15,
          f_tarif (16,
                   KV,
                   NLS,
                   10000)
             tar16,
          f_tarif (17,
                   KV,
                   NLS,
                   10000)
             tar17,
          f_tarif (113,
                   KV,
                   NLS,
                   10000)
             tar113,
          f_tarif (114,
                   KV,
                   NLS,
                   10000)
             tar114,
          f_tarif (115,
                   KV,
                   NLS,
                   10000)
             tar115,
          f_tarif (116,
                   KV,
                   NLS,
                   10000)
             tar116,
          f_tarif (117,
                   KV,
                   NLS,
                   10000)
             tar117,
          f_tarif (118,
                   KV,
                   NLS,
                   10000)
             tar118,
            f_tarif (32,
                     KV,
                     NLS,
                     10000)
          / 100
             tar32,
          NMS
     FROM Accounts
    WHERE     NBS IN ('2560', '2565', '2600', '2603', '2604', '2650')
          AND KV = 980
          AND DAZS IS NULL;

PROMPT *** Create  grants  V_TARIF_RKO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_TARIF_RKO     to ABS_ADMIN;
grant SELECT                                                                 on V_TARIF_RKO     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TARIF_RKO     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TARIF_RKO     to START1;
grant SELECT                                                                 on V_TARIF_RKO     to UPLD;
grant FLASHBACK,SELECT                                                       on V_TARIF_RKO     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TARIF_RKO.sql =========*** End *** ==
PROMPT ===================================================================================== 
