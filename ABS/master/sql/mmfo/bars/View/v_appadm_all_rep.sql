

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPADM_ALL_REP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPADM_ALL_REP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPADM_ALL_REP ("CODEREP", "NAME", "ROLENAME") AS 
  select a.id, a.description, null
  from reports a
minus
select a.id, a.description, null
  from reports a, app_rep b
 where a.id = b.coderep
   and b.codeapp = sys_context('bars_useradm', 'codeapp') 
 ;

PROMPT *** Create  grants  V_APPADM_ALL_REP ***
grant SELECT                                                                 on V_APPADM_ALL_REP to ABS_ADMIN;
grant SELECT                                                                 on V_APPADM_ALL_REP to BARSREADER_ROLE;
grant SELECT                                                                 on V_APPADM_ALL_REP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_APPADM_ALL_REP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPADM_ALL_REP.sql =========*** End *
PROMPT ===================================================================================== 
