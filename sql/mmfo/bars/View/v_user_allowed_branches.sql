

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_ALLOWED_BRANCHES.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_ALLOWED_BRANCHES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_ALLOWED_BRANCHES ("BRANCH") AS 
  select BRANCH
  from branch
 where branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
   and DATE_CLOSED Is Null
 minus
select BRANCH
  from ( select BRANCH
           from VIP_MGR_USR_LST
          minus
         select BRANCH
           from STAFF$BASE ul
          where ID = USER_ID()
       )
;

PROMPT *** Create  grants  V_USER_ALLOWED_BRANCHES ***
grant SELECT                                                                 on V_USER_ALLOWED_BRANCHES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USER_ALLOWED_BRANCHES to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_ALLOWED_BRANCHES.sql =========**
PROMPT ===================================================================================== 
