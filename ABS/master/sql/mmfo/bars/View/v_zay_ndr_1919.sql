

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_NDR_1919.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_NDR_1919 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_NDR_1919 ("NLS", "KV", "ACC") AS 
  select nls, kv, acc from accounts where nbs = 1919 and ob22 in (17,18,19) and (dazs is null or dazs > bankdate) and f_ourmfo() = 380764;

PROMPT *** Create  grants  V_ZAY_NDR_1919 ***
grant SELECT                                                                 on V_ZAY_NDR_1919  to BARSREADER_ROLE;
grant SELECT                                                                 on V_ZAY_NDR_1919  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_NDR_1919  to UPLD;
grant SELECT                                                                 on V_ZAY_NDR_1919  to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_NDR_1919.sql =========*** End ***
PROMPT ===================================================================================== 
