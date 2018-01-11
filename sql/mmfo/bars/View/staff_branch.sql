

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/STAFF_BRANCH.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view STAFF_BRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.STAFF_BRANCH ("ID", "BRANCH") AS 
  SELECT
  ID, BRANCH
FROM STAFF$BASE
WHERE BRANCH LIKE SYS_CONTEXT('bars_context','user_branch_mask')
 ;

PROMPT *** Create  grants  STAFF_BRANCH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_BRANCH    to ABS_ADMIN;
grant SELECT                                                                 on STAFF_BRANCH    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_BRANCH    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_BRANCH    to START1;
grant SELECT                                                                 on STAFF_BRANCH    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_BRANCH    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/STAFF_BRANCH.sql =========*** End *** =
PROMPT ===================================================================================== 
