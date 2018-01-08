

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FREQ_STO.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FREQ_STO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FREQ_STO ("FREQ", "NAME") AS 
  SELECT f.freq freq, f.name
     FROM freq f
    WHERE f.freq not in (2,400,30,999);

PROMPT *** Create  grants  V_FREQ_STO ***
grant SELECT                                                                 on V_FREQ_STO      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FREQ_STO.sql =========*** End *** ===
PROMPT ===================================================================================== 
