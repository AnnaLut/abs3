

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GROUPS_ACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GROUPS_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GROUPS_ACC ("ID", "NAME") AS 
  select id, name from groups_acc /*where nvl(notused,0)=0*/
;

PROMPT *** Create  grants  V_GROUPS_ACC ***
grant SELECT                                                                 on V_GROUPS_ACC    to BARSREADER_ROLE;
grant SELECT                                                                 on V_GROUPS_ACC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_GROUPS_ACC    to CUST001;
grant SELECT                                                                 on V_GROUPS_ACC    to START1;
grant SELECT                                                                 on V_GROUPS_ACC    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_GROUPS_ACC    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GROUPS_ACC.sql =========*** End *** =
PROMPT ===================================================================================== 
