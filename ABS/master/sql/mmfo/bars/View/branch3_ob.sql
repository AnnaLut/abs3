

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BRANCH3_OB.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view BRANCH3_OB ***

  CREATE OR REPLACE FORCE VIEW BARS.BRANCH3_OB ("BRANCH", "NAME", "B040", "DESCRIPTION", "IDPDR", "DATE_OPENED", "DATE_CLOSED", "DELETED", "SAB", "OBL", "TOBO", "NAME_ALT") AS 
  SELECT "BRANCH",
          "NAME",
          "B040",
          "DESCRIPTION",
          "IDPDR",
          "DATE_OPENED",
          "DATE_CLOSED",
          "DELETED",
          "SAB",
          "OBL",
          "TOBO",
          "NAME_ALT"
     FROM branch
    WHERE LENGTH (branch) = 22
          and  branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
          AND date_closed IS NULL;

PROMPT *** Create  grants  BRANCH3_OB ***
grant SELECT                                                                 on BRANCH3_OB      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH3_OB      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BRANCH3_OB.sql =========*** End *** ===
PROMPT ===================================================================================== 
