

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/E_TARIFV.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view E_TARIFV ***

  CREATE OR REPLACE FORCE VIEW BARS.E_TARIFV ("ID", "NAME", "SUMT1", "SUMT", "NLS6", "BRANCH") AS 
  select
 ID, NAME, SUMT1, SUMT, NLS6, --KF,
 BRANCH
from e_tarif$base
where kf=sys_context('bars_context', 'user_mfo')
      and branch =sys_context('bars_context', 'user_branch')
 ;

PROMPT *** Create  grants  E_TARIFV ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on E_TARIFV        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/E_TARIFV.sql =========*** End *** =====
PROMPT ===================================================================================== 
