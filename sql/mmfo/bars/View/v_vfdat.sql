

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_VFDAT.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_VFDAT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_VFDAT ("FDAT", "STAT") AS 
  SELECT to_char(fdat,'dd.mm.yyyy'),
            decode (stat, 9, 'закритий банківський день', 0,'відкритий банківський день', null)
       FROM fdat
   ORDER BY fdat DESC;

PROMPT *** Create  grants  V_VFDAT ***
grant SELECT                                                                 on V_VFDAT         to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_VFDAT.sql =========*** End *** ======
PROMPT ===================================================================================== 
