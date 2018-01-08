

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACTIVE_USERS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACTIVE_USERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACTIVE_USERS ("CLIENT_IDENTIFIER", "LOGIN_NAME", "USER_NAME", "LOGIN_TIME", "CLIENT_HOST", "PROGRAM_NAME", "SID", "SERIAL#", "STATUS") AS 
  select "CLIENT_IDENTIFIER","LOGIN_NAME","USER_NAME","LOGIN_TIME","CLIENT_HOST","PROGRAM_NAME","SID","SERIAL#","STATUS" from v_user_session where login_name not in ('BARS','FINMON','BARSAQ') and login_time >= trunc(sysdate) and program_name = 'barsroot';

PROMPT *** Create  grants  V_ACTIVE_USERS ***
grant SELECT                                                                 on V_ACTIVE_USERS  to ABS_ADMIN;
grant SELECT                                                                 on V_ACTIVE_USERS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACTIVE_USERS  to START1;
grant SELECT                                                                 on V_ACTIVE_USERS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACTIVE_USERS.sql =========*** End ***
PROMPT ===================================================================================== 
