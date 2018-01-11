

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/STAFF_MFO.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view STAFF_MFO ***

  CREATE OR REPLACE FORCE VIEW BARS.STAFF_MFO ("ID", "FIO", "MFO") AS 
  SELECT   a.ID, a.fio, b.mfo
       FROM staff a, staff_banks b
      WHERE a.ID = b.ID(+)
   ORDER BY 1;

PROMPT *** Create  grants  STAFF_MFO ***
grant SELECT                                                                 on STAFF_MFO       to BARSREADER_ROLE;
grant SELECT                                                                 on STAFF_MFO       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_MFO       to START1;
grant SELECT                                                                 on STAFF_MFO       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/STAFF_MFO.sql =========*** End *** ====
PROMPT ===================================================================================== 
