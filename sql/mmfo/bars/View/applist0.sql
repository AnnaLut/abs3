

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/APPLIST0.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view APPLIST0 ***

  CREATE OR REPLACE FORCE VIEW BARS.APPLIST0 ("CODEAPP", "NAME", "HOTKEY", "FRONTEND", "ID") AS 
  select "CODEAPP","NAME","HOTKEY","FRONTEND","ID" from applist  WHERE FRONTEND = 0;

PROMPT *** Create  grants  APPLIST0 ***
grant SELECT                                                                 on APPLIST0        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/APPLIST0.sql =========*** End *** =====
PROMPT ===================================================================================== 
