

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_AR.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_AR ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_AR ("ROL", "ARM", "TABID", "TABNAME", "SEMANTIC", "TYPE", "NAME") AS 
  select PUL.GET('ROLE') ROL, PUL.GET('ARM') ARM, o.tabid ,  m.tabname, m.semantic, o.type, t.name 
from references o , meta_tables m,  TYPEREF t 
where o.tabid = m.tabid (+) and  o.type = t.type  (+) 
and  exists (select 1 from REFAPP  where codeapp = PUL.GET('ARM') and  tabid  = o.tabid);

PROMPT *** Create  grants  M_ROLE_AR ***
grant SELECT                                                                 on M_ROLE_AR       to BARSREADER_ROLE;
grant SELECT                                                                 on M_ROLE_AR       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on M_ROLE_AR       to START1;
grant SELECT                                                                 on M_ROLE_AR       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_AR.sql =========*** End *** ====
PROMPT ===================================================================================== 
