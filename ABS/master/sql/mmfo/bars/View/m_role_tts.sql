

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_TTS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_TTS ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_TTS ("ROL", "GRANTEE_TYPE_ID", "GRANTEE_ID", "RESOURCE_TYPE_ID", "RESOURCE_ID") AS 
  SELECT SUBSTR (PUL.GET ('ROLE'), 1, 100) ROL, GRANTEE_TYPE_ID,  GRANTEE_ID, RESOURCE_TYPE_ID, RESOURCE_ID 
from ADM_RESOURCE 
where GRANTEE_TYPE_ID  = resource_utl.get_resource_type_id('STAFF_ROLE'  ) and GRANTEE_ID = to_number(PUL.GET('RI') ) 
  and RESOURCE_TYPE_ID = resource_utl.get_resource_type_id('TTS' );

PROMPT *** Create  grants  M_ROLE_TTS ***
grant SELECT                                                                 on M_ROLE_TTS      to BARSREADER_ROLE;
grant SELECT                                                                 on M_ROLE_TTS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on M_ROLE_TTS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_TTS.sql =========*** End *** ===
PROMPT ===================================================================================== 
