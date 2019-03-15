

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FOREX_ANI34.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FOREX_ANI34 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FOREX_ANI34 ("B", "E", "G01", "G02", "G03", "G04", "G05", "G06", "G07", "G08", "G08A", "G08B", "G09", "G10", "G11", "G12", "G13", "G14", "G15", "G16", "G17", "G18", "G19", "G20", "G21", "G22", "G23") AS 
  SELECT B,
       E,
       G01,
       G02,
       G03,
       G04,
       G05,
       G06,
       G07,
       G08,
       G08A,
       G08B,
       ROUND (G09, 2) G09,
       ROUND (G10, 2) G10,
       ROUND (G11, 2) G11,
       ROUND (G12, 2) G12,
       ROUND (G13, 2) G13,
       ROUND (G14, 2) G14,
       ROUND (G15, 2) G15,
       ROUND (G16, 2) G16,
       ROUND (G17, 2) G17,
       ROUND (G18, 2) G18,
       ROUND (G19, 2) G19,
       ROUND (G20, 2) G20,
       ROUND (G21, 2) G21,
       G22,
       G23
  FROM TMP_ANI34;

PROMPT *** Create  grants  V_FOREX_ANI34 ***
grant SELECT                                                                 on V_FOREX_ANI34   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FOREX_ANI34   to UPLD;
grant SELECT                                                                 on V_FOREX_ANI34   to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FOREX_ANI34.sql =========*** End *** 
PROMPT ===================================================================================== 
