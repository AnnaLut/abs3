

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPROVABLE_RESOURCE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPROVABLE_RESOURCE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPROVABLE_RESOURCE ("ID", "GRANTEE_TYPE_ID", "GRANTEE_CODE", "GRANTEE_NAME", "RESOURCE_TYPE_NAME", "RESOURCE_CODE", "RESOURCE_NAME", "NEW_ACCESS_MODE", "CURRENT_ACCESS_MODE", "ACTION_TIME", "ACTION_USER") AS 
  select a.id,
       a.grantee_type_id,
       resource_utl.get_resource_code(a.grantee_type_id, a.grantee_id) grantee_code,
       resource_utl.get_resource_name(a.grantee_type_id, a.grantee_id) grantee_name,
       rt.resource_name resource_type_name,
       resource_utl.get_resource_code(a.resource_type_id, a.resource_id) resource_code,
       resource_utl.get_resource_name(a.resource_type_id, a.resource_id) resource_name,
       list_utl.get_item_name(r.access_mode_list_id, a.access_mode_id) new_access_mode,
       list_utl.get_item_name(r.access_mode_list_id, nvl((select s.access_mode_id
                                                          from   adm_resource s
                                                          where  s.grantee_type_id = a.grantee_type_id and
                                                                 s.grantee_id = a.grantee_id and
                                                                 s.resource_type_id = a.resource_type_id and
                                                                 s.resource_id = a.resource_id), r.no_access_item_id)) current_access_mode,
       a.action_time,
       u.logname || ' - ' || u.fio action_user
from   adm_resource_activity a
join   adm_resource_type rt on rt.id = a.resource_type_id
left join adm_resource_type_relation r on r.grantee_type_id = a.grantee_type_id and r.resource_type_id = a.resource_type_id
left join staff$base u on u.id = a.action_user_id
where  a.resolution_type_id is null
;

PROMPT *** Create  grants  V_APPROVABLE_RESOURCE ***
grant SELECT                                                                 on V_APPROVABLE_RESOURCE to BARSREADER_ROLE;
grant SELECT                                                                 on V_APPROVABLE_RESOURCE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_APPROVABLE_RESOURCE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPROVABLE_RESOURCE.sql =========*** 
PROMPT ===================================================================================== 
