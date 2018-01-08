

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_BRNREPS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_BRNREPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_BRNREPS ("ID", "NAME") AS 
  select id, description from reports_b;

PROMPT *** Create  grants  V_USERADM_BRNREPS ***
grant SELECT                                                                 on V_USERADM_BRNREPS to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_BRNREPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_USERADM_BRNREPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USERADM_BRNREPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_BRNREPS.sql =========*** End 
PROMPT ===================================================================================== 
