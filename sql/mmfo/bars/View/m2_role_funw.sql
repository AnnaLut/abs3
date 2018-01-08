

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M2_ROLE_FUNW.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view M2_ROLE_FUNW ***

  CREATE OR REPLACE FORCE VIEW BARS.M2_ROLE_FUNW ("GRANTEE_ID", "RESOURCE_ID", "CODEAPP", "NAME_ARM", "NAME_FUN") AS 
  select r.GRANTEE_ID, r.RESOURCE_ID , a.codeapp, a.name NAME_ARM , o.name NAME_FUN 
from bars.ADM_RESOURCE r, bars.applist1 a, bars.operlist1  o 
where GRANTEE_TYPE_ID = bars.resource_utl.get_resource_type_id('ARM_WEB'     ) 
 and RESOURCE_TYPE_ID = bars.resource_utl.get_resource_type_id('FUNCTION_WEB')
 and a.id =  r.GRANTEE_ID and o.codeoper = r.RESOURCE_ID;

PROMPT *** Create  grants  M2_ROLE_FUNW ***
grant SELECT                                                                 on M2_ROLE_FUNW    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M2_ROLE_FUNW.sql =========*** End *** =
PROMPT ===================================================================================== 
