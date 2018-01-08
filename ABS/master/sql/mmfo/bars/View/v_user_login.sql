

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_LOGIN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_LOGIN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_LOGIN ("ID", "LOGNAME", "FIO", "DISABLE", "ADATE1", "ADATE2", "RDATE1", "RDATE2") AS 
  select s.id, s.logname, s.fio,
       (case
        when u.account_status like '%LOCKED%'  then 1
        else 0
        end ) + (1 - date_is_valid(s.adate1, s.adate2, s.rdate1, s.rdate2)) disable,
       s.adate1, s.adate2, s.rdate1, s.rdate2
  from staff s, dba_users u
 where s.logname = u.username(+);

PROMPT *** Create  grants  V_USER_LOGIN ***
grant SELECT                                                                 on V_USER_LOGIN    to ABS_ADMIN;
grant SELECT                                                                 on V_USER_LOGIN    to BARSREADER_ROLE;
grant SELECT                                                                 on V_USER_LOGIN    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USER_LOGIN    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_LOGIN.sql =========*** End *** =
PROMPT ===================================================================================== 
