

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_FREQUENCIES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_FREQUENCIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_FREQUENCIES ("ID", "NAME") AS 
  select f.freq as id, f.name
  from freq f
 where f.freq in (5, 7, 180, 360, 120, 390, 420, 540)
 order by f.freq desc;

PROMPT *** Create  grants  V_INS_FREQUENCIES ***
grant SELECT                                                                 on V_INS_FREQUENCIES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_FREQUENCIES.sql =========*** End 
PROMPT ===================================================================================== 
