

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DEPRICATED_BRANCH_PARAMETERS.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DEPRICATED_BRANCH_PARAMETERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DEPRICATED_BRANCH_PARAMETERS ("BRANCH", "TAG", "VAL") AS 
  select b.branch branch , bav.attribute_code tag, bav.attribute_value val
from branch_attribute_value bav,
     branch b
where b.branch = bav.branch_code;

PROMPT *** Create  grants  V_DEPRICATED_BRANCH_PARAMETERS ***
grant SELECT                                                                 on V_DEPRICATED_BRANCH_PARAMETERS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DEPRICATED_BRANCH_PARAMETERS.sql ====
PROMPT ===================================================================================== 
