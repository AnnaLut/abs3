

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REZ_OVER.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REZ_OVER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REZ_OVER ("DAT", "RNK", "BRANCH", "ND", "KV", "NLS", "SDATE", "WDATE", "FIN", "KAT", "OBS", "K", "ACC", "CC_ID", "NBS", "BV", "PV", "REZ", "ZAL") AS 
  SELECT FDAT,
          RNK,
          branch,
          ND,
          KV,
          nls,
          SDATE,
          WDATE,
          FIN,
          KAT,
          OBS,
          K,
          acc,
          cc_id,
          nbs,
          BV,
          PV,
          REZ,
          zal
     FROM TEST_MANY_OVR;

PROMPT *** Create  grants  V_REZ_OVER ***
grant SELECT                                                                 on V_REZ_OVER      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REZ_OVER      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REZ_OVER.sql =========*** End *** ===
PROMPT ===================================================================================== 
