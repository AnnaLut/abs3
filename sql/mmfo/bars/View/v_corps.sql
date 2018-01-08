

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORPS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CORPS ("RNK", "NMKU", "RUK", "TELR", "BUH", "TELB", "TEL_FAX", "E_MAIL", "SEAL_ID", "NMK") AS 
  select  c.RNK,
		c.NMKU,
		c.RUK,
		c.TELR,
		c.BUH,
		c.TELB,
		c.TEL_FAX,
		c.E_MAIL,
		c.SEAL_ID,
		c.NMK
from corps c
union all
select  cc.RNK,
		cc.NMKU,
		cc.RUK,
		cc.TELR,
		cc.BUH,
		cc.TELB,
		cc.TEL_FAX,
		cc.E_MAIL,
		cc.SEAL_ID,
		null NMK
from clv_corps cc,
     clv_request q
WHERE cc.rnk = q.rnk
    AND q.req_type IN (0, 2);

PROMPT *** Create  grants  V_CORPS ***
grant SELECT                                                                 on V_CORPS         to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORPS.sql =========*** End *** ======
PROMPT ===================================================================================== 
