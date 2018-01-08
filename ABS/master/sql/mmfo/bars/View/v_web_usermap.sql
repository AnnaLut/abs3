

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WEB_USERMAP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WEB_USERMAP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WEB_USERMAP ("WEBUSER", "DBUSER", "ERRMODE", "WEBPASS", "ADMINPASS", "COMM", "CHGDATE", "BLOCKED", "ATTEMPTS", "USER_ID", "SHARED_USER", "LOG_LEVEL", "CHANGE_DATE", "BANK_DATE") AS 
  SELECT m.webuser,
          m.dbuser,
          m.errmode,
          m.webpass,
          m.adminpass,
          m.comm,
          m.chgdate,
          DECODE (m.blocked, 1, 1, DECODE (s.bax,  NULL, 1,  0, 1,  0))
             blocked,
          m.attempts,
          s.id user_id,
          ts.scheme_user shared_user,
          NVL (ua.log_level, 'INFO') log_level,
          CASE
             WHEN c.mark >= TO_NUMBER (branch_attribute_utl.get_attribute_value (
                                          '/',
                                          'MARKDATE',
                                          0,
                                          0,
                                          0,                 /*default value*/
                                          50))
             THEN
                'Y'
             ELSE
                'N'
          END
             change_date,
          TO_DATE (branch_attribute_utl.get_attribute_value ('/',
                                                             'BANKDATE',
                                                             0,
                                                             0,
                                                             0),
                   'mm/dd/yyyy')
             bank_date
     FROM (
         select webuser,dbuser, errmode,webpass, adminpass, comm, chgdate, blocked, attempts from web_usermap
          union
          select lower(sau.active_directory_name), s.logname, 1, 'b1b3773a05c0ed0176787a4f1574ff0075f7521e', '', 'AD user id=' || s.id, sysdate, 0,0 from STAFF_AD_USER sau, staff$base s where sau.user_id=s.id
           ) m,
          staff$base s,
          staff_templates t,
          staff_templ_schemes ts,
          sec_useraudit ua,
          staff_class c
    WHERE     m.dbuser = s.logname
          AND s.templ_id = t.templ_id
          AND t.scheme_id = ts.scheme_id
          AND s.id = ua.staff_id(+)
          AND s.clsid = c.clsid
          AND s.active = 1;

PROMPT *** Create  grants  V_WEB_USERMAP ***
grant SELECT                                                                 on V_WEB_USERMAP   to APPCORPLIGHT;
grant SELECT                                                                 on V_WEB_USERMAP   to APPSERVER;
grant SELECT                                                                 on V_WEB_USERMAP   to BARSREADER_ROLE;
grant SELECT                                                                 on V_WEB_USERMAP   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WEB_USERMAP   to UPLD;
grant SELECT                                                                 on V_WEB_USERMAP   to WEBTECH;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WEB_USERMAP.sql =========*** End *** 
PROMPT ===================================================================================== 
