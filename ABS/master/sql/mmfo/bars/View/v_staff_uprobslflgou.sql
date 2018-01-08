

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFF_UPROBSLFLGOU.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFF_UPROBSLFLGOU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFF_UPROBSLFLGOU ("ID", "FIO") AS 
  SELECT s.id, s.fio
       FROM STAFF s, OTDEL o1, OTD_USER o2
      WHERE     o1.id IN (3, 48)
            AND o1.id = o2.otd
            AND s.id = o2.userid
            AND (s.disable = 0 OR s.disable IS NULL)
   ORDER BY s.id;

PROMPT *** Create  grants  V_STAFF_UPROBSLFLGOU ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_STAFF_UPROBSLFLGOU to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFF_UPROBSLFLGOU.sql =========*** E
PROMPT ===================================================================================== 
