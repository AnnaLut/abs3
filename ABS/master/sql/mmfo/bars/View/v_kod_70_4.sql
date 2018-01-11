

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KOD_70_4.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KOD_70_4 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KOD_70_4 ("P70", "TXT") AS 
  SELECT p70, txt
       FROM kod_70_4
      WHERE data_o <= bankdate AND NVL (data_c, bankdate) >= bankdate
   ORDER BY p70;

PROMPT *** Create  grants  V_KOD_70_4 ***
grant SELECT                                                                 on V_KOD_70_4      to BARSREADER_ROLE;
grant SELECT                                                                 on V_KOD_70_4      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KOD_70_4      to START1;
grant SELECT                                                                 on V_KOD_70_4      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KOD_70_4.sql =========*** End *** ===
PROMPT ===================================================================================== 
