

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPADM_APP_REP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPADM_APP_REP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPADM_APP_REP ("CODEREP", "NAME", "ROLENAME", "APPROVED", "REVOKED", "DISABLED", "ADATE1", "ADATE2", "RDATE1", "RDATE2") AS 
  select b.id, b.description, null,
       nvl(a.approve, 0)                                        approved,
       nvl(a.revoked, 0)                                        revoked,
       1-date_is_valid(a.adate1, a.adate2, a.rdate1, a.rdate2)  disabled,
       a.adate1, a.adate2, a.rdate1, a.rdate2
  from app_rep a, reports b
 where a.coderep = b.id
   and a.codeapp = sys_context('bars_useradm', 'codeapp') 
 ;

PROMPT *** Create  grants  V_APPADM_APP_REP ***
grant SELECT                                                                 on V_APPADM_APP_REP to ABS_ADMIN;
grant SELECT                                                                 on V_APPADM_APP_REP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPADM_APP_REP.sql =========*** End *
PROMPT ===================================================================================== 
