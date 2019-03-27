

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_ALL_NBUREPS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFFTIPADM_ALL_NBUREPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFFTIPADM_ALL_NBUREPS ("KODF", "A017", "SEMANTIC") AS 
  select a.kodf, a.a017, a.semantic
  from kl_f00 a
 minus
select a.kodf, a.a017, a.semantic
  from kl_f00 a, stafftip_klf00 s
 where a.kodf = s.kodf
   and a.a017 = s.a017
   and s.id   = sys_context('bars_useradm', 'stafftip_id');

PROMPT *** Create  grants  V_STAFFTIPADM_ALL_NBUREPS ***
grant SELECT                                                                 on V_STAFFTIPADM_ALL_NBUREPS to ABS_ADMIN;
grant SELECT                                                                 on V_STAFFTIPADM_ALL_NBUREPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_STAFFTIPADM_ALL_NBUREPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STAFFTIPADM_ALL_NBUREPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_ALL_NBUREPS.sql =========
PROMPT ===================================================================================== 