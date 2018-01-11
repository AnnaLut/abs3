

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TABVAL_SHORT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TABVAL_SHORT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TABVAL_SHORT ("KV", "NAME") AS 
  select kv, lcv||' '||name name from tabval where d_close is null;

PROMPT *** Create  grants  V_TABVAL_SHORT ***
grant SELECT                                                                 on V_TABVAL_SHORT  to BARSREADER_ROLE;
grant SELECT                                                                 on V_TABVAL_SHORT  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TABVAL_SHORT  to START1;
grant SELECT                                                                 on V_TABVAL_SHORT  to UPLD;
grant SELECT                                                                 on V_TABVAL_SHORT  to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TABVAL_SHORT.sql =========*** End ***
PROMPT ===================================================================================== 
