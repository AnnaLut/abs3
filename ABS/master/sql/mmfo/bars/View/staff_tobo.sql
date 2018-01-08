

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/STAFF_TOBO.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view STAFF_TOBO ***

  CREATE OR REPLACE FORCE VIEW BARS.STAFF_TOBO ("USER_ID", "TOBO_ID", "ADDP") AS 
  select  ID , BRANCH_K, ADDP
from STAFF_BRANCH_K 
 ;

PROMPT *** Create  grants  STAFF_TOBO ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_TOBO      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_TOBO      to SALGL;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_TOBO      to STAFF_TOBO;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_TOBO      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on STAFF_TOBO      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/STAFF_TOBO.sql =========*** End *** ===
PROMPT ===================================================================================== 
