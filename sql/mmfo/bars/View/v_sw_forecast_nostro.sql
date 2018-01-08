

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_FORECAST_NOSTRO.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_FORECAST_NOSTRO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW_FORECAST_NOSTRO ("NLS", "NMS", "LCV", "DOS", "KOS", "OSTC", "DOSB", "KOSB", "OSTB") AS 
  SELECT accounts.nls, accounts.nms, tabval.lcv,
       accounts.dos/100 dos, accounts.kos/100 kos, accounts.ostc/100 ostc,
       x.dos/100 dosb, x.kos/100 kosb, (accounts.ostb-x.dos+x.kos)/100  ostb
FROM accounts, tabval,
(
SELECT SUM(amount) dos, 0 kos, a.nls nls, a.kv kv
FROM sw_journal j, accounts a
WHERE a.acc=j.accd AND j.accd IS NOT NULL AND swref NOT IN (SELECT swref FROM sw_oper)
GROUP BY a.nls, a.kv
UNION ALL
SELECT 0 dos, SUM(amount) kos, a.nls nls, a.kv kv
FROM sw_journal j, accounts a
WHERE a.acc=j.acck AND j.acck IS NOT NULL AND swref NOT IN (SELECT swref FROM sw_oper)
GROUP BY a.nls, a.kv
) x
WHERE  x.nls(+)=accounts.nls AND x.kv(+)=accounts.kv AND accounts.nbs IN ('1500', '1600')
AND accounts.dazs IS NULL AND accounts.kv=tabval.kv
ORDER BY accounts.nls ;

PROMPT *** Create  grants  V_SW_FORECAST_NOSTRO ***
grant SELECT                                                                 on V_SW_FORECAST_NOSTRO to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_FORECAST_NOSTRO.sql =========*** E
PROMPT ===================================================================================== 
