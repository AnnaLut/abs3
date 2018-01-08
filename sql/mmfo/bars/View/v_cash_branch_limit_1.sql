

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CASH_BRANCH_LIMIT_1.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CASH_BRANCH_LIMIT_1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CASH_BRANCH_LIMIT_1 ("BRANCH", "KV", "DAT_LIM", "LIM_P", "LIM_M", "L_T") AS 
  SELECT BRANCH,   KV,   DAT_LIM,  LIM_P,   LIM_M,   L_T
   FROM CASH_BRANCH_LIMIT
   WHERE L_T = 1;

PROMPT *** Create  grants  V_CASH_BRANCH_LIMIT_1 ***
grant SELECT                                                                 on V_CASH_BRANCH_LIMIT_1 to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CASH_BRANCH_LIMIT_1 to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CASH_BRANCH_LIMIT_1 to RPBN001;
grant DELETE                                                                 on V_CASH_BRANCH_LIMIT_1 to START1;
grant SELECT                                                                 on V_CASH_BRANCH_LIMIT_1 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CASH_BRANCH_LIMIT_1.sql =========*** 
PROMPT ===================================================================================== 
