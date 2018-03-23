

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BRANCH_OBU.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BRANCH_OBU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BRANCH_OBU ("BRANCH", "NAME", "RU_CODE", "RU_NAME") AS 
  select branch, name, rid, ru
  from branch_obu
 where length(branch) > 15
   and (closedate is null or to_date(closedate,'dd.mm.yyyy') > bankdate);

PROMPT *** Create  grants  V_BRANCH_OBU ***
grant SELECT                                                                 on V_BRANCH_OBU    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BRANCH_OBU    to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BRANCH_OBU.sql =========*** End *** =
PROMPT ===================================================================================== 
