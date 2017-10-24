

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CHECK_VAL_WEB.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CHECK_VAL_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CHECK_VAL_WEB ("KV", "NAME") AS 
  (select kv, lcv || ' ' || name as name
      from tabval
     where kv in (select kvc from ch_kv));

PROMPT *** Create  grants  V_CHECK_VAL_WEB ***
grant SELECT                                                                 on V_CHECK_VAL_WEB to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CHECK_VAL_WEB.sql =========*** End **
PROMPT ===================================================================================== 
