

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_SESSION.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_SESSION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_SESSION ("CLIENT_IDENTIFIER", "LOGIN_NAME", "USER_NAME", "LOGIN_TIME", "CLIENT_HOST", "PROGRAM_NAME", "SID", "SERIAL#", "STATUS") AS 
  select max(s.client_identifier) keep (dense_rank last order by s.id) as client_identifier,
       u.logname login_name,
       u.fio user_name,
       min(s.login_time) keep (dense_rank first order by s.id) as login_time,
       s.client_host,
       max(s.program_name) keep (dense_rank last order by s.id) as program_name,
       max(g.sid) keep (dense_rank last order by s.id) as sid,
       max(g.serial#) keep (dense_rank last order by s.id) as serial#,
       max(g.status) keep (dense_rank last order by s.id) as status
from staff_user_session s
left join staff$base u on u.id = s.user_id
left join gv$session g on g.client_identifier = s.client_identifier
where s.logout_time is null
group by s.user_id, u.logname, u.fio, s.client_host;

PROMPT *** Create  grants  V_USER_SESSION ***
grant SELECT                                                                 on V_USER_SESSION  to BARSREADER_ROLE;
grant SELECT                                                                 on V_USER_SESSION  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USER_SESSION  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_SESSION.sql =========*** End ***
PROMPT ===================================================================================== 
