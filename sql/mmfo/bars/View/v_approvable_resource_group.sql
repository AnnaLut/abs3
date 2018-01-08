

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPROVABLE_RESOURCE_GROUP.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPROVABLE_RESOURCE_GROUP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPROVABLE_RESOURCE_GROUP ("ID", "RESOURCE_CODE", "RESOURCE_NAME") AS 
  select tt.id, tt.resource_code, tt.resource_name
from   adm_resource_type tt
where  tt.id in (select distinct t.grantee_type_id
                 from   adm_resource_type_relation t
                 where  t.must_be_approved = 'Y' or
                        exists (select 1
                                from   adm_resource_activity a
                                where  a.grantee_type_id = t.grantee_type_id and
                                       a.resolution_type_id is null))
;

PROMPT *** Create  grants  V_APPROVABLE_RESOURCE_GROUP ***
grant SELECT                                                                 on V_APPROVABLE_RESOURCE_GROUP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPROVABLE_RESOURCE_GROUP.sql =======
PROMPT ===================================================================================== 
