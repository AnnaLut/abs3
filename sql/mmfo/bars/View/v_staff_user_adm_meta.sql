

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFF_USER_ADM_META.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFF_USER_ADM_META ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFF_USER_ADM_META ("ID", "LOGIN_NAME", "USER_NAME", "BRANCH", "CHANGE_BRANCH_FLAG", "EXTENDED_ACCESS_FLAG", "SECURITY_TOKEN_PASS", "ABS_AUTH_FLAG", "ABS_PASS_HASH", "ORACLE_AUTH_FLAG", "ORACLE_PASS", "ORACLE_ROLES", "AD_AUTH_FLAG", "AD_NAME", "USER_ROLES") AS 
  select t.id,
          t.logname login_name,
          t.fio user_name,
          t.branch branch,
          case when t.can_select_branch = 'Y' then 1 else 0 end change_branch_flag,
          case when t.policy_group = 'CENTER' then 1 else 0 end extended_access_flag,
          t.tabn security_token_pass,
          case when user_utl.check_if_web_user_exists (t.logname) = 'Y' then 1 else 0 end abs_auth_flag,
          cast (null as varchar2 (4000 byte)) abs_pass_hash,
          case when user_utl.check_if_ora_user_exists (t.logname) = 'Y' then 1 else 0 end oracle_auth_flag,
          cast (null as varchar2 (4000 byte)) oracle_pass,
          case when user_utl.get_ora_user_roles (t.logname) is empty then 'Відсутні' else 'Список ролей' end oracle_roles,
          case when a.user_id is null then 0 else 1 end ad_auth_flag,
          a.active_directory_name ad_name,
          case when user_utl.get_user_roles (t.id) is empty then 'Відсутні' else 'Список ролей' end user_roles
     from staff$base t left join staff_ad_user a on a.user_id = t.id
     order by t.id;

PROMPT *** Create  grants  V_STAFF_USER_ADM_META ***
grant SELECT                                                                 on V_STAFF_USER_ADM_META to BARSREADER_ROLE;
grant SELECT                                                                 on V_STAFF_USER_ADM_META to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STAFF_USER_ADM_META to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFF_USER_ADM_META.sql =========*** 
PROMPT ===================================================================================== 
