

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_REFT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_REFT ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_REFT ("TABID", "TABNAME", "SEMANTIC", "TYPE", "NAME") AS 
  select m.tabid,  m.tabname, m.semantic, r.type, t.name 
from references r, TYPEREF t,  meta_tables M where  m.tabid = r.tabid and r.type = t.type  (+);

PROMPT *** Create  grants  M_ROLE_REFT ***
grant SELECT                                                                 on M_ROLE_REFT     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_REFT.sql =========*** End *** ==
PROMPT ===================================================================================== 
