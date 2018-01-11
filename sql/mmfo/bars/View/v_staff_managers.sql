

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFF_MANAGERS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFF_MANAGERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFF_MANAGERS ("ID", "FIO", "LOGNAME", "TYPE", "TABN", "DISABLE", "EXPIRED", "CAN_SELECT_BRANCH", "CLSID") AS 
  select  id, fio, LOGNAME,TYPE,TABN,DISABLE,EXPIRED,CAN_SELECT_BRANCH,CLSID
 from bars.staff$base t WHERE branch LIKE bars.bars_context.get_parent_branch(SYS_CONTEXT ('bars_context', 'user_branch'))||'%'
                   and length(branch) >= length('/______/______/');

PROMPT *** Create  grants  V_STAFF_MANAGERS ***
grant SELECT                                                                 on V_STAFF_MANAGERS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFF_MANAGERS.sql =========*** End *
PROMPT ===================================================================================== 
