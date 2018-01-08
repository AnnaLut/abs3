

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_FUN.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_FUN ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_FUN ("ROL", "ARM", "CODEOPER", "NAME", "FUNCNAME") AS 
  select PUL.GET('ROLE') ROL, PUL.GET('ARM') ARM, codeoper, name, funcname  
from operlist   o
where frontend = PUL.GET('FRO')  
 and exists (select 1 from operapp where codeapp  = PUL.GET('ARM') and  codeoper = o.codeoper);

PROMPT *** Create  grants  M_ROLE_FUN ***
grant SELECT                                                                 on M_ROLE_FUN      to BARSREADER_ROLE;
grant SELECT                                                                 on M_ROLE_FUN      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_FUN.sql =========*** End *** ===
PROMPT ===================================================================================== 
