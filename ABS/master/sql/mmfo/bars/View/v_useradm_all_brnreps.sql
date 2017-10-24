

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_ALL_BRNREPS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_ALL_BRNREPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_ALL_BRNREPS ("ID_R", "NAME", "R_TYPE") AS 
  select b.id, b.description, decode(b.r_type, 1, 'Ë', 'Ö')
  from reports_b b
 where nvl(b.r_type, 0) in (0, 1)
minus
select b.id, b.description, decode(b.r_type, 1, 'Ë', 'Ö')
  from reports_b b, reports_staff s
 where b.id = s.id_r
   and s.id_u = sys_context('bars_useradm', 'user_id')
   and nvl(b.r_type, 0) in (0, 1);

PROMPT *** Create  grants  V_USERADM_ALL_BRNREPS ***
grant SELECT                                                                 on V_USERADM_ALL_BRNREPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USERADM_ALL_BRNREPS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_ALL_BRNREPS.sql =========*** 
PROMPT ===================================================================================== 
