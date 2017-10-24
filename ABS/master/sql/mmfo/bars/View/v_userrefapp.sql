

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERREFAPP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERREFAPP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERREFAPP ("CODEAPP", "APPNAME", "FRONTEND", "TABID", "TABNAME", "SEMANTIC", "ACODE") AS 
  select a.codeapp, a.name appname, a.frontend,
	   m.tabid,m.tabname,m.semantic,
	   r.acode
from meta_tables m, refapp r, applist a, applist_staff s
where m.tabid=r.tabid and r.codeapp=s.codeapp and a.codeapp=s.codeapp
and (s.id=USER_ID OR s.id IN
		(SELECT id_whom FROM staff_substitute
		 WHERE id_who=USER_ID AND date_is_valid(date_start, date_finish, NULL, NULL)=1)
		)
	      AND decode((select nvl(min(to_number(val)),0) from params where par='LOSECURE'),0,NVL(s.approve,0),1)=1
              AND date_is_valid(s.adate1,s.adate2,s.rdate1,s.rdate2)=1
              AND decode((select nvl(min(to_number(val)),0) from params where par='LOSECURE'),0,NVL(r.approve,0),1)=1
              AND date_is_valid(r.adate1,r.adate2,r.rdate1,r.rdate2)=1
 ;

PROMPT *** Create  grants  V_USERREFAPP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_USERREFAPP    to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_USERREFAPP    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USERREFAPP    to BASIC_INFO;
grant SELECT                                                                 on V_USERREFAPP    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USERREFAPP    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERREFAPP.sql =========*** End *** =
PROMPT ===================================================================================== 
