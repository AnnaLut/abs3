

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REPCHOOSE_ISP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REPCHOOSE_ISP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REPCHOOSE_ISP ("ID", "DESCRIPT", "FIO", "BRANCH", "SRT") AS 
  select 0,       'Всі виконавці', '', sys_context('bars_context','user_branch'), 0 from dual
 union all
select user_id, 'Поточний',      fio,  sys_context('bars_context','user_branch'), 1  from staff$base
 where id = user_id
union all
select id, fio, fio, branch, id from staff$base where id <> user_id
and branch like sys_context('bars_context','user_branch')||'%'
 ;

PROMPT *** Create  grants  V_REPCHOOSE_ISP ***
grant SELECT                                                                 on V_REPCHOOSE_ISP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REPCHOOSE_ISP to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REPCHOOSE_ISP.sql =========*** End **
PROMPT ===================================================================================== 
