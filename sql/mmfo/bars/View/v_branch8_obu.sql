

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BRANCH8_OBU.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BRANCH8_OBU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BRANCH8_OBU ("RU_CODE", "RU_NAME") AS 
  select rid, ru
  from branch_obu
 where length(branch) = 8
   and (closedate is null or to_date(closedate,'dd.mm.yyyy') > bankdate);

PROMPT *** Create  grants  V_BRANCH8_OBU ***
grant SELECT                                                                 on V_BRANCH8_OBU   to BARSREADER_ROLE;
grant SELECT                                                                 on V_BRANCH8_OBU   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BRANCH8_OBU   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BRANCH8_OBU.sql =========*** End *** 
PROMPT ===================================================================================== 
