

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RESOURCES_FOR_USER.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RESOURCES_FOR_USER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RESOURCES_FOR_USER ("USER_ID", "LOGIN_NAME", "USER_NAME", "USER_BRANCH", "ROLE_ID", "ROLE_CODE", "ROLE_NAME", "ARM_ID", "ARM_CODE", "ARM_FRONTEND", "ARM_NAME", "FUNCTION_ID", "FUNCTION_NAME", "FUNCTION_TEXT") AS 
  (select user_id,
           login_name,
           user_name,
           user_branch,
           role_id,
           role_code,
           role_name,
           arm_id,
           arm_code,
           arm_frontend,
           arm_name,
           function_id,
           function_name,
           function_text
      from (with resource_activity
                 as (  select s.grantee_type_id,
                              s.grantee_id,
                              s.resource_type_id,
                              s.resource_id,
                              min (s.access_mode_id)
                                 keep (dense_rank last order by s.id)
                                 last_access_mode_id,
                              min (s.resolution_type_id)
                                 keep (dense_rank last order by s.id)
                                 last_resolution_type_id
                         from adm_resource_activity s
                     group by s.grantee_type_id,
                              s.grantee_id,
                              s.resource_type_id,
                              s.resource_id)
            select ra1.grantee_id user_id,
                   s.logname login_name,
                   s.fio user_name,
                   s.branch user_branch,
                   ra1.resource_id role_id,
                   r.role_code role_code,
                   r.role_name role_name,
                   ra2.resource_id arm_id,
                   a.codeapp arm_code,
                   a.frontend arm_frontend,
                   a.name arm_name,
                   ra3.resource_id function_id,
                   o.name function_name,
                   o.funcname function_text
              from resource_activity ra1
                   join adm_resource_type rt1
                      on     rt1.id = ra1.grantee_type_id
                         and rt1.resource_code = 'STAFF_USER'
                   join adm_resource_type rt2
                      on     rt2.id = ra1.resource_type_id
                         and rt2.resource_code = 'STAFF_ROLE'
                   left join staff$base s on s.id = ra1.grantee_id
                   left join staff_role r on r.id = ra1.resource_id
                   join resource_activity ra2
                      on     ra2.grantee_type_id = ra1.resource_type_id
                         and ra2.grantee_id = ra1.resource_id
                   join adm_resource_type rt3
                      on     rt3.id = ra2.resource_type_id
                         and rt3.resource_code in ('ARM_CENTURA', 'ARM_WEB')
                   left join applist a on a.id = ra2.resource_id
                   join
                   (  select s.grantee_type_id,
                             s.grantee_id,
                             s.resource_type_id,
                             s.resource_id,
                             min (s.access_mode_id)
                                keep (dense_rank last order by s.id)
                                last_access_mode_id,
                             min (s.resolution_type_id)
                                keep (dense_rank last order by s.id)
                                last_resolution_type_id
                        from adm_resource_activity s
                    group by s.grantee_type_id,
                             s.grantee_id,
                             s.resource_type_id,
                             s.resource_id) ra3
                      on     ra3.grantee_type_id = ra2.resource_type_id
                         and ra3.grantee_id = ra2.resource_id
                   join adm_resource_type rt4
                      on     rt4.id = ra3.resource_type_id
                         and rt4.resource_code in ('FUNCTION_CENTURA',
                                                   'FUNCTION_WEB')
                   left join operlist o on o.codeoper = ra3.resource_id));

PROMPT *** Create  grants  V_RESOURCES_FOR_USER ***
grant SELECT                                                                 on V_RESOURCES_FOR_USER to BARSREADER_ROLE;
grant SELECT                                                                 on V_RESOURCES_FOR_USER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RESOURCES_FOR_USER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RESOURCES_FOR_USER.sql =========*** E
PROMPT ===================================================================================== 
