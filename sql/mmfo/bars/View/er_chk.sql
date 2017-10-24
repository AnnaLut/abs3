

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ER_CHK.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view ER_CHK ***

  CREATE OR REPLACE FORCE VIEW BARS.ER_CHK ("ID", "LOGNAME", "FIO") AS 
  select id,logname,fio
from staff where
id     in (select id from STAFF_CHK      )               and
id not in (select id from APPLIST_STAFF where codeapp='VIZA')
    OR
id not in (select id from STAFF_CHK      )               and
id     in (select id from APPLIST_STAFF where codeapp='VIZA');

PROMPT *** Create  grants  ER_CHK ***
grant SELECT                                                                 on ER_CHK          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ER_CHK          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ER_CHK.sql =========*** End *** =======
PROMPT ===================================================================================== 
