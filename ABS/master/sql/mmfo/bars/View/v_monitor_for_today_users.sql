

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MONITOR_FOR_TODAY_USERS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MONITOR_FOR_TODAY_USERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MONITOR_FOR_TODAY_USERS ("LOGNAME", "FIO", "FIRST_LOGIN_TIME", "LAST_LOGIN_TIME", "LOGOUT_TIME", "ACTIVE_USERS_COUNT", "TOTAL_USERS_COUNT") AS 
  select d."LOGNAME",d."FIO",d."FIRST_LOGIN_TIME",d."LAST_LOGIN_TIME",d."LOGOUT_TIME",
       sum(case when d.logout_time is null then 1 else 0 end) over() active_users_count,
       count(*) over() total_users_count
from   (select s.logname, s.fio,
               min(t.login_time) keep (dense_rank first order by t.id) first_login_time,
               min(t.login_time) keep (dense_rank last order by t.id) last_login_time,
               min(t.logout_time) keep (dense_rank last order by t.id) logout_time
        from   staff_user_session t
        join staff$base s on s.id = t.user_id and s.logname not in ('AVTOKASSA11', 'BARS', 'BARSAQ', 'FINMON')
        where  t.login_time >= trunc(sysdate)
        group by s.logname, s.fio) d
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MONITOR_FOR_TODAY_USERS.sql =========
PROMPT ===================================================================================== 
