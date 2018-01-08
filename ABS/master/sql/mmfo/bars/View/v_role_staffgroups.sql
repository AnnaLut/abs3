

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ROLE_STAFFGROUPS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ROLE_STAFFGROUPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ROLE_STAFFGROUPS ("STAFF_GROUP_ID", "STAFF_GROUP_NAME", "ROLE_ID", "ROLE_CODE", "ROLE_STATE_ID", "ROLE_STATE_NAME") AS 
  select resource_id staff_group_id,
          g.name staff_group_name,
          grantee_id role_id,
          sr.role_code role_code,
          state_id role_state_id,
          decode (state_id,
                  1, 'Активна',
                  2, 'Заблокована',
                  3, 'Закрита')
             role_state_name
     from adm_resource t, staff_role sr, groups g
    where     t.grantee_type_id = 10                                 -- в роли
          and t.resource_type_id = 1            -- выдано группы пользователей
          and t.grantee_id = sr.id
          and g.id = t.resource_id;

PROMPT *** Create  grants  V_ROLE_STAFFGROUPS ***
grant SELECT                                                                 on V_ROLE_STAFFGROUPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_ROLE_STAFFGROUPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ROLE_STAFFGROUPS.sql =========*** End
PROMPT ===================================================================================== 
