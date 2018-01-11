

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BANKS_OB.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view BANKS_OB ***

  CREATE OR REPLACE FORCE VIEW BARS.BANKS_OB ("MFO", "SAB", "NB", "FMI", "FMO", "KODG", "PM", "KODN", "BLK", "MFOP", "MFOU", "NMO", "SSP") AS 
  SELECT   "MFO",
            "SAB",
            "NB",
            "FMI",
            "FMO",
            "KODG",
            "PM",
            "KODN",
            "BLK",
            "MFOP",
            "MFOU",
            "NMO",
            "SSP"
     FROM   banks
    WHERE   mfou IN
                  (SELECT   mfo
                     FROM   banks
                    WHERE   (mfo = 300465 OR mfop = 300465) AND mfo <> 999999);

PROMPT *** Create  grants  BANKS_OB ***
grant SELECT                                                                 on BANKS_OB        to BARSREADER_ROLE;
grant SELECT                                                                 on BANKS_OB        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BANKS_OB        to START1;
grant SELECT                                                                 on BANKS_OB        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BANKS_OB.sql =========*** End *** =====
PROMPT ===================================================================================== 
