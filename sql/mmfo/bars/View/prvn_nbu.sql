

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PRVN_NBU.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view PRVN_NBU ***

  CREATE OR REPLACE FORCE VIEW BARS.PRVN_NBU ("BRANCH", "FDAT", "KV", "ND", "NLS", "REZ", "REZQ", "RNK", "BV", "BVQ", "NMK", "REZ39", "REZQ39", "REZ23", "REZQ23", "ID", "TIP") AS 
  SELECT BRANCH,
          FDAT,
          KV,
          ND,
          NLS,
          REZ,
          REZQ,
          RNK,
          BV,
          BVQ,
          NMK,
          rez39,
          rezq39,
          rez23,
          rezq23,
          id,
          tip
     FROM nbu23_rez n, V_SFDAT v
    WHERE n.fdat = v.B;

PROMPT *** Create  grants  PRVN_NBU ***
grant SELECT                                                                 on PRVN_NBU        to BARSREADER_ROLE;
grant SELECT                                                                 on PRVN_NBU        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_NBU        to START1;
grant SELECT                                                                 on PRVN_NBU        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PRVN_NBU.sql =========*** End *** =====
PROMPT ===================================================================================== 
