

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFF_USER_ADM.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFF_USER_ADM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFF_USER_ADM ("ID", "LOGIN_NAME", "USER_NAME", "BRANCH_CODE", "BRANCH_NAME", "AUTHENTICATION_MODE_ID", "AUTHENTICATION_MODE_NAME", "STATE_ID", "STATE_NAME", "ADM_COMMENTS") AS 
  select u.id,
       u.logname login_name,
       u.fio user_name,
       u.branch branch_code,
       branch_utl.get_branch_name(u.branch) branch_name,
       cast(null as varchar2(30 char)) authentication_mode_id,
       cast(user_adm_ui.get_user_auth_modes(u.id, u.logname) as varchar2(300 char)) authentication_mode_name,
       case when (u.active = 0) then 4 /*closed*/
            when (u.disable = 1 or u.bax is null or u.bax = 0) then 3 /*locked*/
            else nvl((select 3 /*locked*/
                      from   web_usermap w
                      where  w.dbuser = u.logname and
                             w.blocked = 1), 2 /*active*/)
       end state_id,
       case when (u.active = 0) then 'Закритий'
            when (u.disable = 1 or u.bax is null or u.bax = 0) then 'Блокований'
            else nvl((select 'Блокований'
                      from   web_usermap w
                      where w.dbuser = u.logname and
                            w.blocked = 1), 'Активний')
       end state_name,
       cast(user_adm_ui.get_user_adm_comments(u.id) as varchar2(4000 byte)) adm_comments
from   staff$base u
where  u.active = 1 /*user_utl.USER_STATE_CLOSED*/;

PROMPT *** Create  grants  V_STAFF_USER_ADM ***
grant SELECT                                                                 on V_STAFF_USER_ADM to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFF_USER_ADM.sql =========*** End *
PROMPT ===================================================================================== 
