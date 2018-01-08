

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REPCHOOSE_BRANCH.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REPCHOOSE_BRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REPCHOOSE_BRANCH ("ID", "BRANCH", "NAME", "SRT") AS 
  select 'Поточне', sys_context('bars_context','user_branch'), 'Поточне відідлення', 0 from dual
union all
select 'Підлеглі', sys_context('bars_context','user_branch')||'%', 'Підлеглі відідлення', 1 from dual
where length(sys_context('bars_context','user_branch')) < 22
union all
select branch, branch, name, rownum + 1 from branch
where branch like sys_context('bars_context','user_branch')||'%'
and branch <> sys_context('bars_context','user_branch')
and length(sys_context('bars_context','user_branch')) < 22
 ;

PROMPT *** Create  grants  V_REPCHOOSE_BRANCH ***
grant SELECT                                                                 on V_REPCHOOSE_BRANCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REPCHOOSE_BRANCH to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REPCHOOSE_BRANCH.sql =========*** End
PROMPT ===================================================================================== 
