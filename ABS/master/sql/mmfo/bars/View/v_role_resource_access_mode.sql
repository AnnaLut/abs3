

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ROLE_RESOURCE_ACCESS_MODE.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ROLE_RESOURCE_ACCESS_MODE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ROLE_RESOURCE_ACCESS_MODE ("ID", "RESOURCE_CODE", "RESOURCE_NAME", "ACCESS_MODE_ID", "ACCESS_MODE_CODE", "ACCESS_MODE_NAME") AS 
  select r.id, r.resource_code, r.resource_name, li.list_item_id access_mode_id, li.list_item_code access_mode_code, li.list_item_name access_mode_name
from   adm_resource_type t
join   adm_resource_type_relation rr on rr.grantee_type_id = t.id
join   adm_resource_type r on r.id = rr.resource_type_id
join   list_type lt on lt.id = rr.access_mode_list_id and lt.is_active = 'Y'
join   list_item li on li.list_type_id = lt.id and li.is_active = 'Y'
where  t.resource_code = 'STAFF_ROLE'
;

PROMPT *** Create  grants  V_ROLE_RESOURCE_ACCESS_MODE ***
grant SELECT                                                                 on V_ROLE_RESOURCE_ACCESS_MODE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ROLE_RESOURCE_ACCESS_MODE.sql =======
PROMPT ===================================================================================== 
