

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_USRGRPS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_USRGRPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_USRGRPS ("ID", "NAME") AS 
  select id, name from groups;

PROMPT *** Create  grants  V_USERADM_USRGRPS ***
grant SELECT                                                                 on V_USERADM_USRGRPS to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_USRGRPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_USERADM_USRGRPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USERADM_USRGRPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_USRGRPS.sql =========*** End 
PROMPT ===================================================================================== 
