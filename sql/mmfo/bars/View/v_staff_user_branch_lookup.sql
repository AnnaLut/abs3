

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFF_USER_BRANCH_LOOKUP.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFF_USER_BRANCH_LOOKUP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFF_USER_BRANCH_LOOKUP ("BRANCH", "NAME", "HAS_CHILD", "PARENT_BRANCH") AS 
  select t.branch,
       t.name,
       case when t.branch = lead(t.parent_branch, 1, null) over (order by t.branch) then 'Y'
            else 'N'
       end has_child,
       t.parent_branch
from   (select branch, name, substr(branch, 1, instr(branch, '/', -2)) parent_branch
        from   branch
        where  deleted is null and
               date_closed is null
        connect by prior branch = substr(branch, 1, instr(branch, '/', -2))
        start with branch = '/') t
;

PROMPT *** Create  grants  V_STAFF_USER_BRANCH_LOOKUP ***
grant SELECT                                                                 on V_STAFF_USER_BRANCH_LOOKUP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFF_USER_BRANCH_LOOKUP.sql ========
PROMPT ===================================================================================== 
