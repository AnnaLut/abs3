

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ROLE_RESOURCE_TYPE_LOOKUP.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ROLE_RESOURCE_TYPE_LOOKUP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ROLE_RESOURCE_TYPE_LOOKUP ("ID", "RESOURCE_CODE", "RESOURCE_NAME") AS 
  select t.id, t.resource_code, t.resource_name
from   adm_resource_type t
where  t.id in (select rt.resource_type_id from adm_resource_type_relation rt where rt.grantee_type_id = resource_utl.get_resource_type_id('STAFF_ROLE'))
;

PROMPT *** Create  grants  V_ROLE_RESOURCE_TYPE_LOOKUP ***
grant SELECT                                                                 on V_ROLE_RESOURCE_TYPE_LOOKUP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ROLE_RESOURCE_TYPE_LOOKUP.sql =======
PROMPT ===================================================================================== 
