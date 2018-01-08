

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RESOURCES_FOR_STAFFGROUPS.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RESOURCES_FOR_STAFFGROUPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RESOURCES_FOR_STAFFGROUPS ("STAFF_GROUP_ID", "STAFF_GROUP_NAME", "ACC_GROUP_ID", "ACC_GROUP_NAME", "ACC_GROUP_SCOPE", "ACC", "NLS", "NBS", "KV", "BRANCH", "KF", "ROLE_ID", "ROLE_CODE", "ROLE_STATE_ID", "ACCESS_MODE_ID", "ROLE_STATE_NAME") AS 
  SELECT resource_id   staff_group_id,
          g.name        staff_group_name,
          ga.id  acc_group_id,
          ga.name acc_group_name,
          ga.scope  acc_group_scope,
           a.acc,
          a.nls,
          a.nbs,
          a.kv,
          a.branch,
          a.kf,
          grantee_id    role_id,
          sr.role_code  role_code,
          state_id      role_state_id,
          access_mode_id,
          DECODE (state_id, 1, 'Активна', 2, 'Заблокована', 3, 'Закрита') role_state_name
     FROM adm_resource t,
          staff_role   sr,
          groups       g,
          groups_acc       ga,
          groups_staff_acc gua,
          accounts         a
    WHERE     t.grantee_type_id = 10                                 -- в роли
          AND t.resource_type_id = 1            -- выдано группы пользователей
          AND t.grantee_id = sr.id
          AND g.id = t.resource_id
         and     g.id = gua.idg
          AND ga.id = gua.ida
          AND sec.fit_gmask (a.sec, ga.id) > 0;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RESOURCES_FOR_STAFFGROUPS.sql =======
PROMPT ===================================================================================== 
