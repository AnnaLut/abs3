

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/STAFF_NO_MFO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view STAFF_NO_MFO ***

  CREATE OR REPLACE FORCE VIEW BARS.STAFF_NO_MFO ("ID", "FIO", "DISABLE") AS 
  SELECT   a.ID, a.fio, a.DISABLE
       FROM staff a
      WHERE a.ID NOT IN (SELECT b.ID
                           FROM staff_banks b)
   ORDER BY 1;

PROMPT *** Create  grants  STAFF_NO_MFO ***
grant SELECT                                                                 on STAFF_NO_MFO    to BARSREADER_ROLE;
grant SELECT                                                                 on STAFF_NO_MFO    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_NO_MFO    to START1;
grant SELECT                                                                 on STAFF_NO_MFO    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/STAFF_NO_MFO.sql =========*** End *** =
PROMPT ===================================================================================== 
