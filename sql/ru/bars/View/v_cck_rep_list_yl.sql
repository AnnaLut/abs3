

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_REP_LIST_YL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_REP_LIST_YL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_REP_LIST_YL ("ID", "NAME", "FUNC", "TYPE") AS 
  SELECT  "ID","NAME","FUNC","TYPE" from CCK_AUTO_PROC_LIST t where t.type=1
;

PROMPT *** Create  grants  V_CCK_REP_LIST_YL ***
grant SELECT                                                                 on V_CCK_REP_LIST_YL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_REP_LIST_YL to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_REP_LIST_YL.sql =========*** End 
PROMPT ===================================================================================== 
