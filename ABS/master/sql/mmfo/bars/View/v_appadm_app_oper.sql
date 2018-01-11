

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPADM_APP_OPER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPADM_APP_OPER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPADM_APP_OPER ("CODEOPER", "NAME", "ROLENAME", "APPROVED", "REVOKED", "DISABLED", "ADATE1", "ADATE2", "RDATE1", "RDATE2") AS 
  select b.codeoper, b.name, b.rolename,
       nvl(a.approve, 0)                                        approved,
       nvl(a.revoked, 0)                                        revoked,
       1-date_is_valid(a.adate1, a.adate2, a.rdate1, a.rdate2)  disabled,
       a.adate1, a.adate2, a.rdate1, a.rdate2
  from operapp a, operlist b
 where a.codeoper = b.codeoper
   and a.codeapp  = sys_context('bars_useradm', 'codeapp') 
 ;

PROMPT *** Create  grants  V_APPADM_APP_OPER ***
grant SELECT                                                                 on V_APPADM_APP_OPER to ABS_ADMIN;
grant SELECT                                                                 on V_APPADM_APP_OPER to BARSREADER_ROLE;
grant SELECT                                                                 on V_APPADM_APP_OPER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_APPADM_APP_OPER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPADM_APP_OPER.sql =========*** End 
PROMPT ===================================================================================== 
