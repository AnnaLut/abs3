

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ARM_RESOURCE_TYPE_LOOKUP.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ARM_RESOURCE_TYPE_LOOKUP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ARM_RESOURCE_TYPE_LOOKUP ("ARM_CODE", "ID", "RESOURCE_CODE", "RESOURCE_NAME") AS 
  select a.codeapp arm_code, t.id, t.resource_code, t.resource_name
from   applist a
join   adm_resource_type rt on rt.resource_code = case when a.frontend = 1 then 'ARM_WEB'
                                                       else 'ARM_CENTURA'
                                                  end
join   adm_resource_type_relation rel on rel.grantee_type_id = rt.id
join   adm_resource_type t on t.id = rel.resource_type_id
;

PROMPT *** Create  grants  V_ARM_RESOURCE_TYPE_LOOKUP ***
grant SELECT                                                                 on V_ARM_RESOURCE_TYPE_LOOKUP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ARM_RESOURCE_TYPE_LOOKUP.sql ========
PROMPT ===================================================================================== 
