

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFF.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFF ("SECID", "ID", "FIO", "DBLOGIN", "LOGNAME", "TABN", "BAX", "TBAX", "CLSID", "TASKID", "ADATE1", "ADATE2", "RDATE1", "RDATE2", "DISABLE", "BRANCH") AS 
  select null, s.id, s.fio, logname dblogin, logname logname,
       tabn, bax, tbax, clsid, null,
       adate1,adate2, rdate1, rdate2, disable,
       tobo
  from staff s;

PROMPT *** Create  grants  V_STAFF ***
grant SELECT                                                                 on V_STAFF         to ABS_ADMIN;
grant SELECT                                                                 on V_STAFF         to BARSREADER_ROLE;
grant SELECT                                                                 on V_STAFF         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STAFF         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_STAFF         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFF.sql =========*** End *** ======
PROMPT ===================================================================================== 
