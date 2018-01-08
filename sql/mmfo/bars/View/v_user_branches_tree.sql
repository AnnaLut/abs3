

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_BRANCHES_TREE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_BRANCHES_TREE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_BRANCHES_TREE ("BRANCH", "NAME", "CAN_SELECT", "HAS_CHILD", "PARENT_BRANCH", "BRANCH_PATH") AS 
  with branches (branch) as (
   select user_utl.get_user_branch(user_id) branch from dual
   union all
   select substr(branch, 1, instr(branch, '/', -2)) as branch
   from   branches
   where  substr(branch, 1, instr(branch, '/', -2)) is not null
)
select b.branch,
       b.name,
       f.can_select,
       case when f.branch = lead(substr(f.branch, 1, instr(f.branch, '/', -2)), 1, null) over (order by f.branch) then 1
            else 0
       end has_child,
       substr(b.branch, 1, instr(b.branch, '/', -2)) parent_branch,
       substr(sys_connect_by_path(b.branch, ';'), 2) branch_path
from   branch b
join  (select coalesce(u.branch, d.branch) branch, case when u.branch is null then 0 else 1 end can_select
       from   branches d
       full outer join v_user_branches u on u.branch = d.branch) f on f.branch = b.branch
connect by prior b.branch = substr(b.branch, 1, instr(b.branch, '/', -2))
start with b.branch = '/';

PROMPT *** Create  grants  V_USER_BRANCHES_TREE ***
grant SELECT                                                                 on V_USER_BRANCHES_TREE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_BRANCHES_TREE.sql =========*** E
PROMPT ===================================================================================== 
