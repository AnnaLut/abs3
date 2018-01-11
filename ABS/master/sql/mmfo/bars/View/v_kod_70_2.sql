

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KOD_70_2.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KOD_70_2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KOD_70_2 ("P63", "TXT") AS 
  SELECT p63, txt
       FROM kod_70_2
      WHERE data_o <= bankdate AND NVL (data_c, bankdate) >= bankdate
   ORDER BY p63;

PROMPT *** Create  grants  V_KOD_70_2 ***
grant SELECT                                                                 on V_KOD_70_2      to BARSREADER_ROLE;
grant SELECT                                                                 on V_KOD_70_2      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KOD_70_2      to START1;
grant SELECT                                                                 on V_KOD_70_2      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KOD_70_2.sql =========*** End *** ===
PROMPT ===================================================================================== 
