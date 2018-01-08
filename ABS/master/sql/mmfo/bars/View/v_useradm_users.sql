

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_USERS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_USERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_USERS ("USER_ID", "USER_FIO", "USER_LOGNAME", "USER_CLSID", "USER_TYPE", "USER_TABNUM", "USER_TABNUM_APPROVE", "USER_STATUS", "USER_CHECKIN", "USER_CHECKDATE", "USER_PAYLOCK", "USER_PAYLOCKDATE", "USER_USEARC", "USER_USEGTW", "USER_WEBPROFILE", "USER_BRANCH", "USER_APPROVED", "USER_ACTIVE", "USER_CANSELECTBRANCH", "USER_CHANGEPWD", "USER_TIP", "USER_LICCODE", "USER_LICSTATE", "USER_LICEXPIRED", "UREC_ID", "UREC_STATUS", "UREC_PROXY", "UREC_LOCKDATE", "UREC_EXPIREDATE", "UREC_TSDEFAULT", "UREC_TSTEMP", "UREC_PROFILE", "UREC_CONSGRP") AS 
  select s.id                                                   user_id,
       s.fio                                                  user_fio,
       s.logname                                              user_logname,
       s.clsid                                                user_clsid,
       s.type                                                 user_type,
       s.tabn                                                 user_tabnum,
       n.tabn                                                 user_tabnum_approve,
       (case
        when u.account_status like '%LOCKED%'  then 1
        else 0
        end ) +
        (1 - date_is_valid(s.adate1,
                s.adate2, s.rdate1, s.rdate2))                user_status,
       s.bax                                                  user_checkin,
       s.tbax                                                 user_checkdate,
       s.blk                                                  user_paylock,
       s.tblk                                                 user_paylockdate,
       s.usearc                                               user_usearc,
       s.usegtw                                               user_usegtw,
       s.web_profile                                          user_webprofile,
       s.branch                                               user_branch,
       s.approve                                              user_approved,
       s.active                                               user_active,
       s.can_select_branch                                    user_canselectbranch,
       nvl(s.chgpwd, 'N')                                     user_changepwd,
       s.tip                                                  user_tip,
       bars_useradm.get_user_licstate(s.id)                   user_liccode,
       decode(bars_useradm.get_user_licstate(s.id),
              0, bars_msg.get_msg('ADM', 'USERLIC_VALID'),
              1, bars_msg.get_msg('ADM', 'USERLIC_INVALID'))  user_licstate,
       s.expired                                              user_licexpired,
       u.user_id                                              urec_id,
       (case
        when u.account_status like '%LOCKED%'  then 1
        when (u.account_status like '%EXPIRED%' and u.account_status != 'EXPIRED(GRACE)') then 2
        else 0
        end )                                                 urec_status,
       (select proxy
          from proxy_users
         where client  = s.logname
           and rownum <= 1       )                            urec_proxy,
       u.lock_date                                            urec_lockdate,
       u.expiry_date                                          urec_expiredate,
       u.default_tablespace                                   urec_tsdefault,
       u.temporary_tablespace                                 urec_tstemp,
       u.profile                                              urec_profile,
       u.initial_rsrc_consumer_group                          urec_consgrp
  from staff s, dba_users u, staff_tabn n
 where s.logname = u.username(+)
   and s.id > 0
   and s.id = n.id(+);

PROMPT *** Create  grants  V_USERADM_USERS ***
grant SELECT                                                                 on V_USERADM_USERS to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_USERS to BARSREADER_ROLE;
grant SELECT                                                                 on V_USERADM_USERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USERADM_USERS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USERADM_USERS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_USERS.sql =========*** End **
PROMPT ===================================================================================== 
