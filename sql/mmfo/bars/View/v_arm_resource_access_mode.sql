

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ARM_RESOURCE_ACCESS_MODE.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ARM_RESOURCE_ACCESS_MODE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ARM_RESOURCE_ACCESS_MODE ("ARM_CODE", "ID", "RESOURCE_CODE", "RESOURCE_NAME", "ACCESS_MODE_ID", "ACCESS_MODE_CODE", "ACCESS_MODE_NAME") AS 
  select a.codeapp arm_code, t.id, t.resource_code, t.resource_name, li.list_item_id access_mode_id, li.list_item_code access_mode_code, li.list_item_name access_mode_name
from   applist a
join   adm_resource_type r on r.resource_code = case when a.frontend = 1 then 'ARM_WEB'
                                                     else 'ARM_CENTURA'
                                                end
join   adm_resource_type_relation rr on rr.grantee_type_id = r.id
join   adm_resource_type t on t.id = rr.resource_type_id
join   list_type lt on lt.id = rr.access_mode_list_id and lt.is_active = 'Y'
join   list_item li on li.list_type_id = lt.id and li.is_active = 'Y'
;

PROMPT *** Create  grants  V_ARM_RESOURCE_ACCESS_MODE ***
grant SELECT                                                                 on V_ARM_RESOURCE_ACCESS_MODE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ARM_RESOURCE_ACCESS_MODE.sql ========
PROMPT ===================================================================================== 
