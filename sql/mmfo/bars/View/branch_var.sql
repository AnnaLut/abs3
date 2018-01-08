

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BRANCH_VAR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view BRANCH_VAR ***

  CREATE OR REPLACE FORCE VIEW BARS.BRANCH_VAR ("BRANCH", "NAME") AS 
  SELECT BRANCH, NAME
     FROM BRANCH
    WHERE     LENGTH (BRANCH) >= 15
          AND branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
          and date_closed is null
   UNION ALL
   SELECT BRANCH || '%', '*' || NAME
     FROM BRANCH
    WHERE     LENGTH (BRANCH) = 15
          AND branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
          and date_closed is null
	UNION ALL
   SELECT '/______/______/______/' BRANCH, 'Áðàí÷³ ²²² ð³âíÿ' NAME
   FROM DUAL;

PROMPT *** Create  grants  BRANCH_VAR ***
grant SELECT                                                                 on BRANCH_VAR      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_VAR      to CUST001;
grant SELECT                                                                 on BRANCH_VAR      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BRANCH_VAR.sql =========*** End *** ===
PROMPT ===================================================================================== 
