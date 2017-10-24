

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BRANCH_TIP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BRANCH_TIP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BRANCH_TIP ("BRANCH", "TAG", "VAL") AS 
  select b.branch, 'TIP', p.val
from branch b, (SELECT BRANCH,VAL FROM branch_parameters WHERE tag = 'TIP') p
where b.branch = p.branch (+);

PROMPT *** Create  grants  V_BRANCH_TIP ***
grant SELECT,UPDATE                                                          on V_BRANCH_TIP    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_BRANCH_TIP    to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BRANCH_TIP.sql =========*** End *** =
PROMPT ===================================================================================== 
