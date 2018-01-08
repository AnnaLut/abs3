

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_CHKGRPS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_CHKGRPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_CHKGRPS ("ID", "NAME") AS 
  select idchk, name from chklist;

PROMPT *** Create  grants  V_USERADM_CHKGRPS ***
grant SELECT                                                                 on V_USERADM_CHKGRPS to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_CHKGRPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_USERADM_CHKGRPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USERADM_CHKGRPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_CHKGRPS.sql =========*** End 
PROMPT ===================================================================================== 
