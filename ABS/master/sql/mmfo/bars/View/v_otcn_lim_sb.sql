

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OTCN_LIM_SB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OTCN_LIM_SB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OTCN_LIM_SB ("UK_VALUE", "NLS", "KV", "LIM", "FDAT") AS 
  select a.acc || ';' || to_char(t.fdat, 'ddmmyyyy') uk_value, a.nls, a.kv, t.lim, t.fdat
from   otcn_lim_sb t
join   accounts a on a.acc = t.acc and
                     a.dazs is null;

PROMPT *** Create  grants  V_OTCN_LIM_SB ***
grant SELECT                                                                 on V_OTCN_LIM_SB   to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_OTCN_LIM_SB   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OTCN_LIM_SB   to UPLD;
grant FLASHBACK,SELECT                                                       on V_OTCN_LIM_SB   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OTCN_LIM_SB.sql =========*** End *** 
PROMPT ===================================================================================== 
