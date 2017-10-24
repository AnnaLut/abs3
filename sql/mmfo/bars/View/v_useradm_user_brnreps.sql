

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_USER_BRNREPS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_USER_BRNREPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_USER_BRNREPS ("ID_R", "NAME", "R_TYPE") AS 
  select b.id_r, a.description, decode(a.r_type, 1, 'Ë', 'Ö')
  from reports_staff b, reports_b a
 where nvl(a.r_type, 0) in (0, 1)
   and b.id_r = a.id
   and b.id_u = sys_context('bars_useradm', 'user_id');

PROMPT *** Create  grants  V_USERADM_USER_BRNREPS ***
grant SELECT                                                                 on V_USERADM_USER_BRNREPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USERADM_USER_BRNREPS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_USER_BRNREPS.sql =========***
PROMPT ===================================================================================== 
