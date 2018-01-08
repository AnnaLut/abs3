

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BRANCH_OP_BR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view BRANCH_OP_BR ***

  CREATE OR REPLACE FORCE VIEW BARS.BRANCH_OP_BR ("BRANCH", "NAME", "B040", "DESCRIPTION", "IDPDR", "DATE_OPENED", "DATE_CLOSED", "DELETED", "SAB", "OBL", "TOBO", "NAME_ALT") AS 
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
    WHERE branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
          AND date_closed IS NULL;

PROMPT *** Create  grants  BRANCH_OP_BR ***
grant SELECT                                                                 on BRANCH_OP_BR    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_OP_BR    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BRANCH_OP_BR.sql =========*** End *** =
PROMPT ===================================================================================== 
