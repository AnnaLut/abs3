

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZVT_KOL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZVT_KOL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZVT_KOL ("FDAT", "KOL") AS 
  SELECT fdat, COUNT (*) kol    FROM PART_ZVT_DOC   GROUP BY fdat;

PROMPT *** Create  grants  V_ZVT_KOL ***
grant SELECT                                                                 on V_ZVT_KOL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZVT_KOL       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZVT_KOL.sql =========*** End *** ====
PROMPT ===================================================================================== 
