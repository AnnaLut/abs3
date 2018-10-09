
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/branch_var.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.BRANCH_VAR ("BRANCH", "NAME") AS 
  SELECT BRANCH, NAME
  FROM BRANCH
 WHERE LENGTH(BRANCH) >= 15
   AND branch LIKE SYS_CONTEXT('bars_context', 'user_branch_mask')
   AND date_closed IS NULL
 UNION ALL
SELECT BRANCH || '%', '*' || NAME
  FROM BRANCH
 WHERE LENGTH(BRANCH) = 15
   AND branch LIKE SYS_CONTEXT('bars_context', 'user_branch_mask')
   AND date_closed IS NULL
 UNION ALL
SELECT BRANCH || '______/', 'Áðàí÷³ ²² ð³âíÿ ' || NAME
  FROM BRANCH
 WHERE LENGTH (BRANCH) = 8
   AND branch LIKE SYS_CONTEXT('bars_context', 'user_branch_mask')
   and date_closed is null
 UNION ALL
SELECT BRANCH || '______/______/', 'Áðàí÷³ ²²² ð³âíÿ ' || NAME
  FROM BRANCH
 WHERE LENGTH (BRANCH) = 8
   AND branch LIKE SYS_CONTEXT('bars_context', 'user_branch_mask')
   and date_closed is null
 UNION ALL
SELECT '/______/______/______/' BRANCH, 'Âñ³ áðàí÷³ ²²² ð³âíÿ' NAME
  FROM DUAL
;
 show err;
 
PROMPT *** Create  grants  BRANCH_VAR ***
grant SELECT                                                                 on BRANCH_VAR      to BARSREADER_ROLE;
grant SELECT                                                                 on BRANCH_VAR      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_VAR      to CUST001;
grant SELECT                                                                 on BRANCH_VAR      to START1;
grant SELECT                                                                 on BRANCH_VAR      to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/branch_var.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 
