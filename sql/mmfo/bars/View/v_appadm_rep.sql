

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPADM_REP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPADM_REP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPADM_REP ("ID", "NAME", "ROLENAME") AS 
  select id, name, null from reports;

PROMPT *** Create  grants  V_APPADM_REP ***
grant SELECT                                                                 on V_APPADM_REP    to ABS_ADMIN;
grant SELECT                                                                 on V_APPADM_REP    to BARSREADER_ROLE;
grant SELECT                                                                 on V_APPADM_REP    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_APPADM_REP    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPADM_REP.sql =========*** End *** =
PROMPT ===================================================================================== 
