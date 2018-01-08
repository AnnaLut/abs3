

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_LIMIT_KV.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_LIMIT_KV ***

  CREATE OR REPLACE FORCE VIEW BARS.V_LIMIT_KV ("ID", "DESCRIPT") AS 
  SELECT 0, 'Всі валюти' FROM DUAL
   UNION ALL
   SELECT DISTINCT KV, (SELECT name FROM TABVAL$GLOBAL t WHERE t.kv = c.kv)
   FROM CASH_BRANCH_LIMIT c;

PROMPT *** Create  grants  V_LIMIT_KV ***
grant SELECT                                                                 on V_LIMIT_KV      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_LIMIT_KV      to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_LIMIT_KV.sql =========*** End *** ===
PROMPT ===================================================================================== 
