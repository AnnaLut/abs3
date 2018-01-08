

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BPK_OUR_BRANCH.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view BPK_OUR_BRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.BPK_OUR_BRANCH ("BRANCH", "NAME") AS 
  select branch, name
  from branch
 where branch like sys_context('bars_context','user_branch_mask')
   and length(branch) >= 15
 ;

PROMPT *** Create  grants  BPK_OUR_BRANCH ***
grant SELECT                                                                 on BPK_OUR_BRANCH  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_OUR_BRANCH  to OBPC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BPK_OUR_BRANCH.sql =========*** End ***
PROMPT ===================================================================================== 
