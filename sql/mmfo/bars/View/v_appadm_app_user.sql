

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPADM_APP_USER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPADM_APP_USER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPADM_APP_USER ("ID", "NAME", "ROLENAME", "APPROVED", "REVOKED", "DISABLED", "ADATE1", "ADATE2", "RDATE1", "RDATE2") AS 
  select b.id, b.fio, null,
       nvl(a.approve, 0)                                        approved,
       nvl(a.revoked, 0)                                        revoked,
       1-date_is_valid(a.adate1, a.adate2, a.rdate1, a.rdate2)  disabled,
       a.adate1, a.adate2, a.rdate1, a.rdate2
  from applist_staff a, staff b
 where a.id      = b.id
   and a.codeapp = sys_context('bars_useradm', 'codeapp') 
 ;

PROMPT *** Create  grants  V_APPADM_APP_USER ***
grant SELECT                                                                 on V_APPADM_APP_USER to ABS_ADMIN;
grant SELECT                                                                 on V_APPADM_APP_USER to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPADM_APP_USER.sql =========*** End 
PROMPT ===================================================================================== 
