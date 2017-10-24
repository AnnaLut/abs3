

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFF_USER_ROLE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFF_USER_ROLE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFF_USER_ROLE ("USER_ID", "ROLE_ID", "ROLE_CODE", "ROLE_NAME", "IS_GRANTED", "IS_APPROVED") AS 
  select d.user_id,
       d.role_id,
       d.role_code,
       d.role_name,
       case when d.not_approved_access_mode_id is null then d.access_mode_id else d.not_approved_access_mode_id end is_granted,
       case when d.not_approved_access_mode_id is null then 1 else 0 end is_approved
from   (select u.id user_id,
               rol.id role_id,
               rol.role_code,
               rol.role_name,
               nvl((select a.access_mode_id
                    from   adm_resource a
                    where  a.grantee_type_id = ut.id and
                           a.resource_type_id = rt.id and
                           a.grantee_id = u.id and
                           a.resource_id = r.item_id), rr.no_access_item_id) access_mode_id,
               (select min(a.access_mode_id) keep (dense_rank last order by a.access_mode_id)
                from   adm_resource_activity a
                where  a.grantee_type_id = ut.id and
                       a.resource_type_id = rt.id and
                       a.grantee_id = u.id and
                       a.resource_id = r.item_id and
                       a.resolution_type_id is null) not_approved_access_mode_id
        from   staff$base u
        join   adm_resource_type ut on ut.resource_code = 'STAFF_USER'
        join   adm_resource_type rt on rt.resource_code = 'STAFF_ROLE'
        join   adm_resource_type_relation rr on rr.grantee_type_id = ut.id and rr.resource_type_id = rt.id
        join   table(resource_utl.get_available_resources(rt.id)) r on 1 = 1
        join   staff_role rol on rol.id = r.item_id and rol.state_id = 1 /*user_role_utl.ROLE_STATE_ACTIVE*/) d
;

PROMPT *** Create  grants  V_STAFF_USER_ROLE ***
grant SELECT                                                                 on V_STAFF_USER_ROLE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFF_USER_ROLE.sql =========*** End 
PROMPT ===================================================================================== 
