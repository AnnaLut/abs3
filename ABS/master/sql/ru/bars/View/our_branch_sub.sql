

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OUR_BRANCH_SUB.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view OUR_BRANCH_SUB ***

  CREATE OR REPLACE FORCE VIEW BARS.OUR_BRANCH_SUB ("BRANCH", "NAME", "B040", "DESCRIPTION") AS 
  select branch, name, b040, description
  from branch
 where (branch <> sys_context('bars_context','user_branch')
        and
	branch like sys_context('bars_context','user_branch_mask'))
	or
        sys_context('bars_context','user_branch') = '/';

PROMPT *** Create  grants  OUR_BRANCH_SUB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OUR_BRANCH_SUB  to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on OUR_BRANCH_SUB  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OUR_BRANCH_SUB  to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OUR_BRANCH_SUB  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OUR_BRANCH_SUB.sql =========*** End ***
PROMPT ===================================================================================== 
