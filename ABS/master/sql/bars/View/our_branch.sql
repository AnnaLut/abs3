

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OUR_BRANCH.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view OUR_BRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.OUR_BRANCH ("BRANCH", "NAME", "B040", "DESCRIPTION", "DATE_CLOSED") AS 
  SELECT "BRANCH",
          "NAME",
          "B040",
          "DESCRIPTION",
		  "DATE_CLOSED"
     FROM BRANCH
    WHERE BRANCH LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask') and length(branch)>15;

PROMPT *** Create  grants  OUR_BRANCH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OUR_BRANCH      to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on OUR_BRANCH      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OUR_BRANCH      to DPT_ROLE;
grant SELECT                                                                 on OUR_BRANCH      to OBPC;
grant SELECT                                                                 on OUR_BRANCH      to PYOD001;
grant SELECT                                                                 on OUR_BRANCH      to RPBN001;
grant SELECT                                                                 on OUR_BRANCH      to RPBN002;
grant SELECT                                                                 on OUR_BRANCH      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OUR_BRANCH      to WR_ALL_RIGHTS;
grant SELECT                                                                 on OUR_BRANCH      to WR_RATES;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OUR_BRANCH.sql =========*** End *** ===
PROMPT ===================================================================================== 
