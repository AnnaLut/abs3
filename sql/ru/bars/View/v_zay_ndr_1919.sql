

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_NDR_1919.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_NDR_1919 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_NDR_1919 ("NLS", "KV", "ACC") AS 
  select nls, kv, acc from accounts where nbs = 1919 and ob22 in (17,18,19,23) and (dazs is null or dazs > bankdate) and f_ourmfo() = 380764;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_NDR_1919.sql =========*** End ***
PROMPT ===================================================================================== 
