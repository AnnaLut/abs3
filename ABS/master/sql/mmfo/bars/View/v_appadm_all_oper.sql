

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPADM_ALL_OPER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPADM_ALL_OPER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPADM_ALL_OPER ("CODEOPER", "NAME", "ROLENAME") AS 
  select a.codeoper, a.name, a.rolename
  from operlist a
 where a.frontend = ( select frontend
                        from applist
                       where codeapp = sys_context('bars_useradm', 'codeapp') )
minus
select a.codeoper, a.name, a.rolename
  from operlist a, operapp b
 where a.codeoper = b.codeoper
   and b.codeapp  = sys_context('bars_useradm', 'codeapp') 
 ;

PROMPT *** Create  grants  V_APPADM_ALL_OPER ***
grant SELECT                                                                 on V_APPADM_ALL_OPER to ABS_ADMIN;
grant SELECT                                                                 on V_APPADM_ALL_OPER to BARSREADER_ROLE;
grant SELECT                                                                 on V_APPADM_ALL_OPER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_APPADM_ALL_OPER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPADM_ALL_OPER.sql =========*** End 
PROMPT ===================================================================================== 
