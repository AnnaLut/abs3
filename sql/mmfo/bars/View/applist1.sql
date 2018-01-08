

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/APPLIST1.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view APPLIST1 ***

  CREATE OR REPLACE FORCE VIEW BARS.APPLIST1 ("ID", "CODEAPP", "NAME") AS 
  select id, codeapp, codeapp||'/'||name  NAME  from applist  WHERE FRONTEND = 1;

PROMPT *** Create  grants  APPLIST1 ***
grant SELECT                                                                 on APPLIST1        to BARSREADER_ROLE;
grant SELECT                                                                 on APPLIST1        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on APPLIST1        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/APPLIST1.sql =========*** End *** =====
PROMPT ===================================================================================== 
