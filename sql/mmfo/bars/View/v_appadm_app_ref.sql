

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPADM_APP_REF.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPADM_APP_REF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPADM_APP_REF ("TABID", "NAME", "ROLENAME", "ACODE", "REFTYPE", "APPROVED", "REVOKED", "DISABLED", "ADATE1", "ADATE2", "RDATE1", "RDATE2") AS 
  select b.tabid, c.semantic, b.role2edit, decode(a.acode,'RW',1,0), t.name,
       nvl(a.approve, 0)                                        approved,
       nvl(a.revoked, 0)                                        revoked,
       1-date_is_valid(a.adate1, a.adate2, a.rdate1, a.rdate2)  disabled,
       a.adate1, a.adate2, a.rdate1, a.rdate2
  from refapp a, references b, meta_tables c, typeref t
 where a.tabid = b.tabid
   and b.tabid = c.tabid
   and b.type  = t.type
   and a.codeapp = sys_context('bars_useradm', 'codeapp') 
 ;

PROMPT *** Create  grants  V_APPADM_APP_REF ***
grant SELECT                                                                 on V_APPADM_APP_REF to ABS_ADMIN;
grant SELECT                                                                 on V_APPADM_APP_REF to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPADM_APP_REF.sql =========*** End *
PROMPT ===================================================================================== 
