

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_ALL_USRGRPS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_ALL_USRGRPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_ALL_USRGRPS ("IDG", "NAME") AS 
  select a.id, a.name
  from groups a
minus
select a.id, a.name
  from groups a, groups_staff l
 where a.id  = l.idg
   and l.idu = sys_context('bars_useradm', 'user_id')
 ;

PROMPT *** Create  grants  V_USERADM_ALL_USRGRPS ***
grant SELECT                                                                 on V_USERADM_ALL_USRGRPS to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_ALL_USRGRPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_USERADM_ALL_USRGRPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USERADM_ALL_USRGRPS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USERADM_ALL_USRGRPS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_ALL_USRGRPS.sql =========*** 
PROMPT ===================================================================================== 
