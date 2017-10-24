

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_BRANCHES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_BRANCHES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_BRANCHES ("BRANCH", "NAME") AS 
  select branch, name
  from branch
 where deleted is null
   and date_closed is null
   and branch like sys_context('bars_context','user_branch_mask')
;

PROMPT *** Create  grants  V_USERADM_BRANCHES ***
grant SELECT                                                                 on V_USERADM_BRANCHES to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_BRANCHES to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USERADM_BRANCHES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_BRANCHES.sql =========*** End
PROMPT ===================================================================================== 
