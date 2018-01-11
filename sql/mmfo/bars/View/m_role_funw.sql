

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_FUNW.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_FUNW ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_FUNW ("TI", "RI", "GRANTEE_TYPE_ID", "GRANTEE_ID", "RESOURCE_TYPE_ID", "RESOURCE_ID") AS 
  select resource_utl.get_resource_type_id('STAFF_ROLE') TI, to_number( PUL.GET('RI')) RI,     GRANTEE_TYPE_ID, GRANTEE_ID, RESOURCE_TYPE_ID , RESOURCE_ID 
from ADM_RESOURCE 
where GRANTEE_TYPE_ID  = resource_utl.get_resource_type_id('ARM_WEB'     ) 
  and GRANTEE_ID       = PUL.GET('RI_ARM') 
  and RESOURCE_TYPE_ID = resource_utl.get_resource_type_id('FUNCTION_WEB');

PROMPT *** Create  grants  M_ROLE_FUNW ***
grant SELECT                                                                 on M_ROLE_FUNW     to BARSREADER_ROLE;
grant SELECT                                                                 on M_ROLE_FUNW     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on M_ROLE_FUNW     to START1;
grant SELECT                                                                 on M_ROLE_FUNW     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_FUNW.sql =========*** End *** ==
PROMPT ===================================================================================== 
