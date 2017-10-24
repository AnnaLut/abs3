

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPADM_REF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPADM_REF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPADM_REF ("ID", "NAME", "ROLENAME") AS 
  select r.tabid, t.tabname, r.role2edit
  from references r, meta_tables t
 where r.tabid = t.tabid;

PROMPT *** Create  grants  V_APPADM_REF ***
grant SELECT                                                                 on V_APPADM_REF    to ABS_ADMIN;
grant SELECT                                                                 on V_APPADM_REF    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPADM_REF.sql =========*** End *** =
PROMPT ===================================================================================== 
