

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANKS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANKS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANKS ("MFO", "NB", "SAB", "BLK") AS 
  SELECT   mfo, nb, sab, blk
       FROM banks
      WHERE mfou = f_ourmfo
   ORDER BY 1;

PROMPT *** Create  grants  V_BANKS ***
grant SELECT                                                                 on V_BANKS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BANKS         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANKS.sql =========*** End *** ======
PROMPT ===================================================================================== 
