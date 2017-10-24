

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_NP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_NP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_NP ("ID", "NP") AS 
  SELECT "ID", "NP"
     FROM np
    WHERE id = user_id;

PROMPT *** Create  grants  V_USER_NP ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USER_NP       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_USER_NP       to WR_DOC_INPUT;
grant FLASHBACK,SELECT                                                       on V_USER_NP       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_NP.sql =========*** End *** ====
PROMPT ===================================================================================== 
