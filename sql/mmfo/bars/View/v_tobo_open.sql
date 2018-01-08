

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TOBO_OPEN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TOBO_OPEN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TOBO_OPEN ("TOBO", "NAME") AS 
  select tobo,name from tobo
 where bankdate_g>=date_opened
   and (date_closed is null or bankdate_g<=date_closed)
   and tobo like sys_context('bars_context','user_branch_mask')
;

PROMPT *** Create  grants  V_TOBO_OPEN ***
grant SELECT                                                                 on V_TOBO_OPEN     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TOBO_OPEN     to RCC_DEAL;
grant SELECT                                                                 on V_TOBO_OPEN     to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TOBO_OPEN     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TOBO_OPEN.sql =========*** End *** ==
PROMPT ===================================================================================== 
