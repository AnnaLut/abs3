

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CASH_BRANCH_LIMIT_3.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CASH_BRANCH_LIMIT_3 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CASH_BRANCH_LIMIT_3 ("BR", "BRANCH", "KV", "LIM_P", "LIM_M", "L_T", "DAT_LIM") AS 
  SELECT SUBSTR (BRANCH, 19, 3) BR, BRANCH, KV, LIM_P, LIM_M, L_T, DAT_LIM
   FROM CASH_BRANCH_LIMIT
  WHERE L_T = 3;

PROMPT *** Create  grants  V_CASH_BRANCH_LIMIT_3 ***
grant SELECT                                                                 on V_CASH_BRANCH_LIMIT_3 to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on V_CASH_BRANCH_LIMIT_3 to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT,UPDATE                                                   on V_CASH_BRANCH_LIMIT_3 to RPBN001;
grant SELECT                                                                 on V_CASH_BRANCH_LIMIT_3 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CASH_BRANCH_LIMIT_3.sql =========*** 
PROMPT ===================================================================================== 
