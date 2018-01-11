

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KORP_KL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view KORP_KL ***

  CREATE OR REPLACE FORCE VIEW BARS.KORP_KL ("G01", "G02", "G03", "G04", "G05", "G06", "G07", "G08", "G09", "G10", "G11", "G12", "G13", "G14", "G15", "G16", "G17", "G18", "G19", "G20", "G21", "G22", "G23", "G24", "G25") AS 
  (SELECT G01,
           G02,
           G03,
           G04,
           G05,
           G06,
           G07,
           G08,
           G09,
           G10,
           G11,
           G12,
           G13,
           G14,
           G15,
           G16,
           G17,
           G18,
           G19,
           G20,
           G21,
           G22,
           G23,
           G24,
           G25
      FROM ANI_DEL6
     WHERE G06 IN (2546,
                   2610,
                   2615,
                   2651,
                   2652,
                   2600,
                   2650,
                   2525));

PROMPT *** Create  grants  KORP_KL ***
grant SELECT                                                                 on KORP_KL         to BARSREADER_ROLE;
grant SELECT                                                                 on KORP_KL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KORP_KL         to DPT_ADMIN;
grant SELECT                                                                 on KORP_KL         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KORP_KL.sql =========*** End *** ======
PROMPT ===================================================================================== 
