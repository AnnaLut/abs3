

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_ALL_APPS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_ALL_APPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_ALL_APPS ("CODEAPP", "NAME") AS 
  select a.codeapp, a.name
  from applist a
minus
select a.codeapp, a.name
  from staff$base s, applist_staff g, applist a
 where s.id      = g.id
   and g.codeapp = a.codeapp
   and s.id      = sys_context('bars_useradm', 'user_id')
 ;

PROMPT *** Create  grants  V_USERADM_ALL_APPS ***
grant SELECT                                                                 on V_USERADM_ALL_APPS to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_ALL_APPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_USERADM_ALL_APPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USERADM_ALL_APPS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USERADM_ALL_APPS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_ALL_APPS.sql =========*** End
PROMPT ===================================================================================== 
