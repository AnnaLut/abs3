

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPLIST.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPLIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPLIST ("CODEAPP", "NAME", "HOTKEY", "FRONTEND", "APOWNER") AS 
  SELECT a.codeapp, a.name, a.hotkey, a.frontend, s.id
   FROM applist a, applist_staff s
   WHERE
     a.codeapp=s.codeapp AND (s.id=USER_ID OR s.id IN (
       SELECT id_whom FROM staff_substitute
       WHERE id_who=USER_ID AND date_is_valid(date_start, date_finish, NULL, NULL)=1))
     AND decode((select nvl(min(to_number(val)),0) from params where par='LOSECURE'),0,NVL(s.approve,0),1)=1
     AND date_is_valid(s.adate1,s.adate2,s.rdate1,s.rdate2)=1
 ;

PROMPT *** Create  grants  V_APPLIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_APPLIST       to ABS_ADMIN;
grant SELECT                                                                 on V_APPLIST       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_APPLIST       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_APPLIST       to BASIC_INFO;
grant SELECT                                                                 on V_APPLIST       to START1;
grant SELECT                                                                 on V_APPLIST       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_APPLIST       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPLIST.sql =========*** End *** ====
PROMPT ===================================================================================== 
