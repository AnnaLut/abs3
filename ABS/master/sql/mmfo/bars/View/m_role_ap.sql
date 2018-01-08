

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_AP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_AP ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_AP ("ROL", "ARM", "ID", "DESCRIPTION", "IDF", "NAME") AS 
  select PUL.GET('ROLE') ROL, PUL.GET('ARM') ARM, o.id , o.description, o.idf  , f.name
from reports o , REPORTSF f 
where exists (select 1 from APP_REP where codeapp = PUL.GET('ARM') and  coderep = o.id) and o.idf = f.idf (+);

PROMPT *** Create  grants  M_ROLE_AP ***
grant SELECT                                                                 on M_ROLE_AP       to BARSREADER_ROLE;
grant SELECT                                                                 on M_ROLE_AP       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on M_ROLE_AP       to START1;
grant SELECT                                                                 on M_ROLE_AP       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_AP.sql =========*** End *** ====
PROMPT ===================================================================================== 
