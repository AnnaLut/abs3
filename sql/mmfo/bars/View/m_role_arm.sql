

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_ARM.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_ARM ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_ARM ("ROL", "ID", "CODEAPP", "NAME", "FUN", "REP", "REF") AS 
  select PUL.GET('ROLE') ROL, id, codeapp, name,
   (select count(*) from operapp where codeapp=a.codeapp) FUN,
   (select count(*) from APP_REP where codeapp=a.codeapp) REP,
   (select count(*) from REFAPP  where codeapp=a.codeapp) REF
from applist a 
where nvl(frontend,0) = 0  
  and  exists (select 1 from V_RESOURCES_FOR_ROLE  where substr(ROLE_CODE,1,100) = PUL.GET('ROLE')  and resource_id = a.id and RESOURCE_TYPE = 'АРМи користувачів (Centura)' );

PROMPT *** Create  grants  M_ROLE_ARM ***
grant SELECT                                                                 on M_ROLE_ARM      to BARSREADER_ROLE;
grant SELECT                                                                 on M_ROLE_ARM      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_ARM.sql =========*** End *** ===
PROMPT ===================================================================================== 
