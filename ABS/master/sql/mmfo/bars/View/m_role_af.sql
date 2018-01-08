

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_AF.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_AF ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_AF ("ROL", "ARM", "CODEOPER", "NAME", "FUNCNAME", "FRONTEND") AS 
  select PUL.GET('ROLE') ROL, PUL.GET('ARM') ARM, codeoper, name, funcname, frontend   
from operlist   o
where 
--frontend = PUL.GET('FRO') and
 exists (select 1 from operapp where codeapp  = PUL.GET('ARM') and  codeoper = o.codeoper);

PROMPT *** Create  grants  M_ROLE_AF ***
grant SELECT                                                                 on M_ROLE_AF       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on M_ROLE_AF       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_AF.sql =========*** End *** ====
PROMPT ===================================================================================== 
