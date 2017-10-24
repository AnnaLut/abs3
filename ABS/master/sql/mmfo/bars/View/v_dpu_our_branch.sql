

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_OUR_BRANCH.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_OUR_BRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_OUR_BRANCH ("BRANCH", "NAME") AS 
  select BRANCH
     , NAME
  from BRANCH
 where BRANCH like sys_context( 'bars_context', 'user_branch_mask' )
   and BRANCH like '/______/______/%'
   and DATE_CLOSED Is Null;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_OUR_BRANCH.sql =========*** End *
PROMPT ===================================================================================== 
