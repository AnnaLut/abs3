

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_ALL_NBUREPS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_ALL_NBUREPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_ALL_NBUREPS ("KODF", "A017", "NAME") AS 
  select a.kodf, a.a017, a.semantic
  from kl_f00 a
minus
select a.kodf, a.a017, a.semantic
  from kl_f00 a, staff_klf00 l
 where a.kodf = l.kodf
   and a.a017 = l.a017
   and l.id   = sys_context('bars_useradm', 'user_id')
 ;

PROMPT *** Create  grants  V_USERADM_ALL_NBUREPS ***
grant SELECT                                                                 on V_USERADM_ALL_NBUREPS to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_ALL_NBUREPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_USERADM_ALL_NBUREPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USERADM_ALL_NBUREPS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USERADM_ALL_NBUREPS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_ALL_NBUREPS.sql =========*** 
PROMPT ===================================================================================== 
