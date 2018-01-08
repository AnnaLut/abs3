

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ER_TT.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view ER_TT ***

  CREATE OR REPLACE FORCE VIEW BARS.ER_TT ("ID", "LOGNAME", "FIO") AS 
  select id,logname,fio
from staff where
id     in (select id from STAFF_TTS      )               and
id not in (select id from APPLIST_STAFF a, operapp o
           where a.codeapp=o.codeapp and o.codeoper=18 )
    OR
id not in (select id from STAFF_TTS      )               and
id     in (select id from APPLIST_STAFF a, operapp o
           where a.codeapp=o.codeapp and o.codeoper=18 );

PROMPT *** Create  grants  ER_TT ***
grant SELECT                                                                 on ER_TT           to BARSREADER_ROLE;
grant SELECT                                                                 on ER_TT           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ER_TT           to START1;
grant SELECT                                                                 on ER_TT           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ER_TT.sql =========*** End *** ========
PROMPT ===================================================================================== 
