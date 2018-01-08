

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_A.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_A ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_A ("ROL", "ID", "CODEAPP", "NAME", "FRONTEND", "FUN", "REP", "REF") AS 
  select PUL.GET('ROLE') ROL, id, codeapp, name, frontend ,
   (select count(*) from operapp where codeapp=a.codeapp) FUN,
   (select count(*) from APP_REP where codeapp=a.codeapp) REP,
   (select count(*) from REFAPP  where codeapp=a.codeapp) REF
from applist a 
where 
frontend = PUL.GET('FRO') and 
 exists (select 1 from V_RESOURCES_FOR_ROLE where substr(ROLE_CODE,1,100) = PUL.GET('ROLE') );

PROMPT *** Create  grants  M_ROLE_A ***
grant SELECT                                                                 on M_ROLE_A        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on M_ROLE_A        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_A.sql =========*** End *** =====
PROMPT ===================================================================================== 
