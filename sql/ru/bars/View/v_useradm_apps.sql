

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_APPS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_APPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_APPS ("ID", "NAME") AS 
  select codeapp, name from applist;

PROMPT *** Create  grants  V_USERADM_APPS ***
grant SELECT                                                                 on V_USERADM_APPS  to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_APPS  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_APPS.sql =========*** End ***
PROMPT ===================================================================================== 
