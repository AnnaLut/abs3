

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WEB_USERMAP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WEB_USERMAP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WEB_USERMAP ("WEBUSER", "DBUSER", "ERRMODE", "WEBPASS", "ADMINPASS", "COMM", "CHGDATE", "BLOCKED", "ATTEMPTS", "USER_ID", "SHARED_USER", "LOG_LEVEL", "CHANGE_DATE", "BANK_DATE") AS 
  select m.webuser
            ,m.dbuser
            ,m.errmode
            ,m.webpass
            ,m.adminpass
            ,m.comm
            ,m.chgdate
            ,decode(m.blocked, 1, 1, decode(s.bax,  null, 1,  0, 1,    0)) blocked
            ,m.attempts
            ,s.id user_id
            ,ts.scheme_user shared_user
            ,nvl(ua.log_level, 'INFO') log_level
            ,(case when c.mark >= p2.change_level then 'Y' else 'N' end)
                 change_date
            , case when s.branch = '/' then
                        (select to_date(p.val, 'mm/dd/yyyy') from params$base p
                         where  p.par = 'BANKDATE' and
                                p.kf = (select val from params$global g
                                        where g.par = 'GLB-MFO'))
                   else
                       (select to_date(p.val, 'mm/dd/yyyy') from params$base p
                        where  p.par = 'BANKDATE' and
                               p.kf = substr(s.branch, 2, 6))
              end bank_date
    from     web_usermap m
            ,staff$base s
            ,staff_templates t
            ,staff_templ_schemes ts
            ,sec_useraudit ua
            ,staff_class c
            ,(select to_number(val) change_level
              from    params$global
              where    par = 'MARKDATE') p2
    where  m.dbuser = s.logname
             and s.templ_id = t.templ_id
             and t.scheme_id = ts.scheme_id
             and s.id = ua.staff_id(+)
             and s.clsid = c.clsid;

PROMPT *** Create  grants  V_WEB_USERMAP ***
grant SELECT                                                                 on V_WEB_USERMAP   to APPSERVER;
grant SELECT                                                                 on V_WEB_USERMAP   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WEB_USERMAP   to WEBTECH;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WEB_USERMAP.sql =========*** End *** 
PROMPT ===================================================================================== 
