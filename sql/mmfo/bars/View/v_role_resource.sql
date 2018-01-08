

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ROLE_RESOURCE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ROLE_RESOURCE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ROLE_RESOURCE ("ROLE_ID", "RESOURCE_TYPE_ID", "RESOURCE_TYPE_NAME", "RESOURCE_ID", "RESOURCE_CODE", "RESOURCE_NAME", "IS_GRANTED", "IS_GRANTED_NAME", "IS_APPROVED") AS 
  select f.role_id,
       f.resource_type_id,
       f.resource_type_name,
       f.resource_id,
       f.resource_code,
       f.resource_name,
       case when f.not_approved_access_mode_id is null then f.access_mode_id else f.not_approved_access_mode_id end is_granted,
       list_utl.get_item_name(f.access_mode_list_id, nvl(case when f.not_approved_access_mode_id is null then f.access_mode_id else f.not_approved_access_mode_id end, f.no_access_item_id)) is_granted_name,
       case when f.not_approved_access_mode_id is null then 1 else 0 end is_approved
from   (select r.id role_id,
               t.id resource_type_id,
               t.resource_name resource_type_name,
               d.item_id resource_id,
               d.item_code resource_code,
               d.item_name resource_name,
               rr.access_mode_list_id,
               rr.no_access_item_id,
               nvl((select a.access_mode_id
                    from   adm_resource a
                    where  a.grantee_type_id = rrt.id and
                           a.resource_type_id = t.id and
                           a.grantee_id = r.id and
                           a.resource_id = d.item_id), rr.no_access_item_id) access_mode_id,
               (select min(a.access_mode_id) keep (dense_rank last order by a.access_mode_id)
                from   adm_resource_activity a
                where  a.grantee_type_id = rrt.id and
                       a.resource_type_id = t.id and
                       a.grantee_id = r.id and
                       a.resource_id = d.item_id and
                       a.resolution_type_id is null) not_approved_access_mode_id
        from   staff_role r
        join   adm_resource_type rrt on rrt.resource_code = 'STAFF_ROLE'
        join   adm_resource_type_relation rr on rr.grantee_type_id = rrt.id
        join   adm_resource_type t on t.id = rr.resource_type_id
        join   table(resource_utl.get_available_resources(t.id)) d on 1 = 1
        left join adm_resource a on a.grantee_type_id = rrt.id and
                                    a.resource_type_id = t.id and
                                    a.grantee_id = r.id and
                                    a.resource_id = d.item_id) f
;

PROMPT *** Create  grants  V_ROLE_RESOURCE ***
grant SELECT                                                                 on V_ROLE_RESOURCE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ROLE_RESOURCE.sql =========*** End **
PROMPT ===================================================================================== 
