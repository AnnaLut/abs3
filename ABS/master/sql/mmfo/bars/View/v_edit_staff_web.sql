

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EDIT_STAFF_WEB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EDIT_STAFF_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EDIT_STAFF_WEB ("FIO", "LOGNAME", "BRANCH") AS 
  SELECT fio, logname, branch
     FROM staff$base
    WHERE branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  V_EDIT_STAFF_WEB ***
grant SELECT                                                                 on V_EDIT_STAFF_WEB to BARSREADER_ROLE;
grant FLASHBACK,SELECT,UPDATE                                                on V_EDIT_STAFF_WEB to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_EDIT_STAFF_WEB to UPLD;
grant FLASHBACK,SELECT                                                       on V_EDIT_STAFF_WEB to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EDIT_STAFF_WEB.sql =========*** End *
PROMPT ===================================================================================== 
