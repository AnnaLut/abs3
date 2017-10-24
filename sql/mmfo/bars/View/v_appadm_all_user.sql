

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPADM_ALL_USER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPADM_ALL_USER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPADM_ALL_USER ("ID", "NAME", "ROLENAME") AS 
  select a.id, a.fio, null
  from staff a
minus
select a.id, a.fio, null
  from staff a, applist_staff b
 where a.id      = b.id
   and b.codeapp = sys_context('bars_useradm', 'codeapp') 
 ;

PROMPT *** Create  grants  V_APPADM_ALL_USER ***
grant SELECT                                                                 on V_APPADM_ALL_USER to ABS_ADMIN;
grant SELECT                                                                 on V_APPADM_ALL_USER to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPADM_ALL_USER.sql =========*** End 
PROMPT ===================================================================================== 
