

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BRANCH_OWN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BRANCH_OWN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BRANCH_OWN ("BRANCH", "NAME", "B040", "DESCRIPTION", "IDPDR", "DATE_OPENED", "DATE_CLOSED", "DELETED", "SAB") AS 
  select BRANCH,NAME, B040,DESCRIPTION, IDPDR,DATE_OPENED, DATE_CLOSED, DELETED, SAB
from branch
 ;

PROMPT *** Create  grants  V_BRANCH_OWN ***
grant SELECT                                                                 on V_BRANCH_OWN    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BRANCH_OWN    to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BRANCH_OWN    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BRANCH_OWN.sql =========*** End *** =
PROMPT ===================================================================================== 
