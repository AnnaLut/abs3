

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFF_UPRKLIROZR.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFF_UPRKLIROZR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFF_UPRKLIROZR ("ID", "FIO") AS 
  SELECT   s.id, s.fio
       FROM   STAFF s, OTDEL o1, OTD_USER o2
      WHERE       o1.id = 5
              AND o1.id = o2.otd
              AND s.id = o2.userid
              AND (s.disable = 0 OR s.disable IS NULL)
   ORDER BY   s.id;

PROMPT *** Create  grants  V_STAFF_UPRKLIROZR ***
grant SELECT                                                                 on V_STAFF_UPRKLIROZR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STAFF_UPRKLIROZR to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFF_UPRKLIROZR.sql =========*** End
PROMPT ===================================================================================== 
