

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_FUNC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_FUNC ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_FUNC ("ROL", "ARM", "AI", "CODEOPER", "NAME", "FUNCNAME") AS 
  select substr(PUL.GET('ROLE'),1,100) ROL, substr( PUL.GET('ARM'),1, 10) ARM, to_number(PUL.GET('RI_ARM')) AI,
      b.RESOURCE_ID codeoper, a.name, a.funcname  
from (select * from operlist where nvl(frontend,0) = 0)  a,        
     (select * from ADM_RESOURCE where GRANTEE_TYPE_ID  = resource_utl.get_resource_type_id('ARM_CENTURA'     ) and GRANTEE_ID=PUL.GET('RI_ARM') 
                                   and RESOURCE_TYPE_ID = resource_utl.get_resource_type_id('FUNCTION_CENTURA') 
    ) b 
where b.RESOURCE_ID = a.codeoper (+);

PROMPT *** Create  grants  M_ROLE_FUNC ***
grant SELECT                                                                 on M_ROLE_FUNC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on M_ROLE_FUNC     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_FUNC.sql =========*** End *** ==
PROMPT ===================================================================================== 
