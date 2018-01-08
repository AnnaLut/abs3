

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPADM_USER.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPADM_USER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPADM_USER ("ID", "NAME", "ROLENAME") AS 
  select id, fio, null from staff;

PROMPT *** Create  grants  V_APPADM_USER ***
grant SELECT                                                                 on V_APPADM_USER   to ABS_ADMIN;
grant SELECT                                                                 on V_APPADM_USER   to BARSREADER_ROLE;
grant SELECT                                                                 on V_APPADM_USER   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_APPADM_USER   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPADM_USER.sql =========*** End *** 
PROMPT ===================================================================================== 
