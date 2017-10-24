

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACTIVE_USERS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACTIVE_USERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACTIVE_USERS ("PROGRAM", "USERNAME", "TABN", "FIO", "TERMINAL", "LOGON_TIME", "BANKDATE", "SID", "SERIAL#", "STATUS") AS 
  select g.program, g.username, s.tabn, s.fio, g.terminal,
       g.logon_time, null, g.sid, g.serial#, g.status
from gv$session g, staff s
where g.username = s.logname;

PROMPT *** Create  grants  V_ACTIVE_USERS ***
grant SELECT                                                                 on V_ACTIVE_USERS  to ABS_ADMIN;
grant SELECT                                                                 on V_ACTIVE_USERS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACTIVE_USERS  to START1;
grant SELECT                                                                 on V_ACTIVE_USERS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACTIVE_USERS.sql =========*** End ***
PROMPT ===================================================================================== 
