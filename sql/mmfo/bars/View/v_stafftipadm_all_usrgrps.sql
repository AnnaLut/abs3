

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_ALL_USRGRPS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFFTIPADM_ALL_USRGRPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFFTIPADM_ALL_USRGRPS ("IDG", "NAME") AS 
  select a.id, a.name
  from groups a
 minus
select a.id, a.name
  from groups a, stafftip_grp s
 where a.id  = s.idg
   and s.idu = sys_context('bars_useradm', 'stafftip_id');

PROMPT *** Create  grants  V_STAFFTIPADM_ALL_USRGRPS ***
grant SELECT                                                                 on V_STAFFTIPADM_ALL_USRGRPS to ABS_ADMIN;
grant SELECT                                                                 on V_STAFFTIPADM_ALL_USRGRPS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_ALL_USRGRPS.sql =========
PROMPT ===================================================================================== 
