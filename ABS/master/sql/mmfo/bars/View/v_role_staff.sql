

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ROLE_STAFF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ROLE_STAFF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ROLE_STAFF ("USER_ID", "USER_NAME", "BRANCH", "USER_LOGNAME", "ROLE_ID", "ROLE_CODE", "ROLE_STATE_ID", "ROLE_STATE_NAME") AS 
  select grantee_id user_id,
          g.fio user_name,
          g.branch branch,
          g.logname user_logname,
          resource_id role_id,
          sr.role_code role_code,
          state_id role_state_id,
          decode (state_id,
                  1, 'Активна',
                  2, 'Заблокована',
                  3, 'Закрита')
             role_state_name
     from adm_resource t, staff_role sr, staff$base g
    where     t.grantee_type_id = 11                                 -- в роли
          and t.resource_type_id = 10                        --користувачі абс
          and t.grantee_id = sr.id
          and t.grantee_id = g.id;

PROMPT *** Create  grants  V_ROLE_STAFF ***
grant SELECT                                                                 on V_ROLE_STAFF    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ROLE_STAFF.sql =========*** End *** =
PROMPT ===================================================================================== 
