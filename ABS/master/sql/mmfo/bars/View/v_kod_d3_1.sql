

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KOD_D3_1.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KOD_D3_1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KOD_D3_1 ("P40", "TXT") AS 
  SELECT p40, p40||' '||txt
       FROM kod_d3_1
      WHERE data_o <= bankdate AND NVL (data_c, bankdate) >= bankdate
   ORDER BY p40;

PROMPT *** Create  grants  V_KOD_D3_1 ***
grant SELECT                                                                 on V_KOD_D3_1      to BARSREADER_ROLE;
grant SELECT                                                                 on V_KOD_D3_1      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KOD_D3_1      to START1;
grant SELECT                                                                 on V_KOD_D3_1      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KOD_D3_1.sql =========*** End *** ===
PROMPT ===================================================================================== 
