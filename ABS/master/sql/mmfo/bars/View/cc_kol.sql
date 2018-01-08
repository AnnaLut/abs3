

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_KOL.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_KOL ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_KOL ("VIDD", "SOUR", "NLS") AS 
  select vidd,sour, nls
from CC_KOL$BASE
where BRANCH=sys_context('bars_context','user_branch')
 ;

PROMPT *** Create  grants  CC_KOL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_KOL          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_KOL          to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_KOL          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_KOL.sql =========*** End *** =======
PROMPT ===================================================================================== 
