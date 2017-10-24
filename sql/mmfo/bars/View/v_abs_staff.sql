

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ABS_STAFF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ABS_STAFF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ABS_STAFF ("ID", "FIO") AS 
  SELECT s.ID, s.FIO
       FROM STAFF$BASE s, DBA_USERS d
      WHERE d.account_status = 'OPEN'
        AND TRIM (UPPER (d.username)) = TRIM (UPPER (s.logname))
        AND s.bax = 1
        AND s.id not in (select id from v_grc_staff)
        AND s.id not in (1013,2070,10001,10002,20094)
   ORDER BY s.id;

PROMPT *** Create  grants  V_ABS_STAFF ***
grant SELECT                                                                 on V_ABS_STAFF     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ABS_STAFF     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ABS_STAFF.sql =========*** End *** ==
PROMPT ===================================================================================== 
