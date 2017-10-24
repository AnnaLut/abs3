

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_FREQ.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_FREQ ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_FREQ ("ID", "NAME") AS 
  select f.freq id, f.name
from   freq f
where  f.freq in (1, 5, 7, 360);

PROMPT *** Create  grants  V_STO_FREQ ***
grant SELECT                                                                 on V_STO_FREQ      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_FREQ.sql =========*** End *** ===
PROMPT ===================================================================================== 
