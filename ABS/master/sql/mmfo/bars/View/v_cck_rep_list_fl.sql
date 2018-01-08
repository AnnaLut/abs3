

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_REP_LIST_FL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_REP_LIST_FL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_REP_LIST_FL ("ID", "NAME", "FUNC", "TYPE") AS 
  SELECT  "ID","NAME","FUNC","TYPE" from CCK_AUTO_PROC_LIST t where t.type=0
;

PROMPT *** Create  grants  V_CCK_REP_LIST_FL ***
grant SELECT                                                                 on V_CCK_REP_LIST_FL to BARSREADER_ROLE;
grant SELECT                                                                 on V_CCK_REP_LIST_FL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_REP_LIST_FL to RCC_DEAL;
grant SELECT                                                                 on V_CCK_REP_LIST_FL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_REP_LIST_FL.sql =========*** End 
PROMPT ===================================================================================== 
