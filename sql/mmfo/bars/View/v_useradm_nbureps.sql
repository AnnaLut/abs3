

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_NBUREPS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_NBUREPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_NBUREPS ("ID", "NAME") AS 
  select kodf||' '||a017, semantic from kl_f00;

PROMPT *** Create  grants  V_USERADM_NBUREPS ***
grant SELECT                                                                 on V_USERADM_NBUREPS to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_NBUREPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_USERADM_NBUREPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USERADM_NBUREPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_NBUREPS.sql =========*** End 
PROMPT ===================================================================================== 
