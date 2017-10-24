

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/STAFF_B040.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view STAFF_B040 ***

  CREATE OR REPLACE FORCE VIEW BARS.STAFF_B040 ("ID", "FIO", "B040", "DISABLE") AS 
  SELECT s.ID,
       s.fio,
       b.b040,
       s.DISABLE
     FROM staff$base s 
     left join branch b on b.branch=s.branch;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/STAFF_B040.sql =========*** End *** ===
PROMPT ===================================================================================== 
