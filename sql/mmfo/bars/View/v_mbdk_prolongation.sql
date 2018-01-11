

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_PROLONGATION.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBDK_PROLONGATION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_PROLONGATION ("ND", "FDAT", "NPP", "TXT", "KV", "NLS") AS 
  SELECT p.nd,
            p.fdat,
            p.npp,
            SUBSTR (p.txt, 1, 250) txt,
            a.kv,
            a.nls
       FROM cc_prol p, accounts a
      WHERE p.acc = a.acc
   ORDER BY p.fdat, p.npp;

PROMPT *** Create  grants  V_MBDK_PROLONGATION ***
grant SELECT                                                                 on V_MBDK_PROLONGATION to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBDK_PROLONGATION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBDK_PROLONGATION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBDK_PROLONGATION.sql =========*** En
PROMPT ===================================================================================== 
