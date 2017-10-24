

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NP.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NP ("NP") AS 
  SELECT n.np
     FROM np n, staff s
    WHERE n.ID = s.ID
      AND s.branch = SYS_CONTEXT ('bars_context', 'user_branch');

PROMPT *** Create  grants  V_NP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_NP            to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_NP            to BARS_ACCESS_DEFROLE;
grant DELETE,SELECT,UPDATE                                                   on V_NP            to PYOD001;
grant DELETE,FLASHBACK,SELECT,UPDATE                                         on V_NP            to WR_ALL_RIGHTS;
grant DELETE,FLASHBACK,SELECT,UPDATE                                         on V_NP            to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NP.sql =========*** End *** =========
PROMPT ===================================================================================== 
