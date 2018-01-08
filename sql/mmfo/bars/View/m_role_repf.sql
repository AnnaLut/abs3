

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_REPF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_REPF ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_REPF ("ID", "DESCRIPTION", "IDF", "NAME") AS 
  select r.id, r.description, r.idf, f.name from reports r, REPORTSF f where r.idf = f.idf (+);

PROMPT *** Create  grants  M_ROLE_REPF ***
grant SELECT                                                                 on M_ROLE_REPF     to BARSREADER_ROLE;
grant SELECT                                                                 on M_ROLE_REPF     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on M_ROLE_REPF     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_REPF.sql =========*** End *** ==
PROMPT ===================================================================================== 
