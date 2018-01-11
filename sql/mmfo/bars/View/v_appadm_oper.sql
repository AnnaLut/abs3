

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPADM_OPER.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPADM_OPER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPADM_OPER ("ID", "NAME", "ROLENAME") AS 
  select codeoper, name, rolename from operlist;

PROMPT *** Create  grants  V_APPADM_OPER ***
grant SELECT                                                                 on V_APPADM_OPER   to ABS_ADMIN;
grant SELECT                                                                 on V_APPADM_OPER   to BARSREADER_ROLE;
grant SELECT                                                                 on V_APPADM_OPER   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_APPADM_OPER   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPADM_OPER.sql =========*** End *** 
PROMPT ===================================================================================== 
