

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_USE.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_USE ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_USE ("GRANTEE_TYPE_ID", "GRANTEE_ID", "RESOURCE_TYPE_ID", "RESOURCE_ID", "ACCESS_MODE_ID") AS 
  select "GRANTEE_TYPE_ID","GRANTEE_ID","RESOURCE_TYPE_ID","RESOURCE_ID","ACCESS_MODE_ID" from ADM_RESOURCE 
where GRANTEE_TYPE_ID  = resource_utl.get_resource_type_id('STAFF_USER') and RESOURCE_TYPE_ID = resource_utl.get_resource_type_id('STAFF_ROLE');

PROMPT *** Create  grants  M_ROLE_USE ***
grant SELECT                                                                 on M_ROLE_USE      to BARSREADER_ROLE;
grant SELECT                                                                 on M_ROLE_USE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on M_ROLE_USE      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_USE.sql =========*** End *** ===
PROMPT ===================================================================================== 
