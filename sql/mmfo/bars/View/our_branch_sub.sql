

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OUR_BRANCH_SUB.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view OUR_BRANCH_SUB ***

  CREATE OR REPLACE FORCE VIEW BARS.OUR_BRANCH_SUB ("BRANCH", "NAME", "B040", "DESCRIPTION") AS 
  SELECT branch,
          name,
          b040,
          description
     FROM branch
    WHERE  nvl(description,0) not in ('3')
        and
      (    branch <> SYS_CONTEXT ('bars_context', 'user_branch')
              AND branch LIKE
                     SYS_CONTEXT ('bars_context', 'user_branch_mask'))
          OR SYS_CONTEXT ('bars_context', 'user_branch') = '/';

PROMPT *** Create  grants  OUR_BRANCH_SUB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OUR_BRANCH_SUB  to ABS_ADMIN;
grant SELECT                                                                 on OUR_BRANCH_SUB  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OUR_BRANCH_SUB  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OUR_BRANCH_SUB  to START1;
grant SELECT                                                                 on OUR_BRANCH_SUB  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OUR_BRANCH_SUB  to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on OUR_BRANCH_SUB  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OUR_BRANCH_SUB.sql =========*** End ***
PROMPT ===================================================================================== 
