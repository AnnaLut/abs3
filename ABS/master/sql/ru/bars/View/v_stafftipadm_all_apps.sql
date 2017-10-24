

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_ALL_APPS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFFTIPADM_ALL_APPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFFTIPADM_ALL_APPS ("CODEAPP", "NAME") AS 
  select a.codeapp, a.name
  from applist a
 minus
select a.codeapp, a.name
  from applist a, stafftip_app s
 where a.codeapp = s.codeapp
   and s.id = sys_context('bars_useradm', 'stafftip_id');

PROMPT *** Create  grants  V_STAFFTIPADM_ALL_APPS ***
grant SELECT                                                                 on V_STAFFTIPADM_ALL_APPS to ABS_ADMIN;
grant SELECT                                                                 on V_STAFFTIPADM_ALL_APPS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_ALL_APPS.sql =========***
PROMPT ===================================================================================== 
