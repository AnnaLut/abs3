

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_ACCOUNTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_ACCOUNTS ("ACC", "RNK", "NLS", "NMS", "KV", "BRANCH", "DAOS", "OSTC", "TIP") AS 
  select a.acc,
       a.rnk,
       a.nls,
       a.nms,
       a.kv,
       a.branch,
       a.daos,
       a.ostc,
       a.tip
from   accounts a
where  a.nbs in ('2625') and
       a.kv = 980 and
       a.tip in ('W4A', 'W4B', 'W4C', 'W4V') and
       a.dazs is null and
       a.kf = sys_context('bars_context', 'user_mfo');

PROMPT *** Create  grants  V_STO_ACCOUNTS ***
grant SELECT                                                                 on V_STO_ACCOUNTS  to BARSREADER_ROLE;
grant SELECT                                                                 on V_STO_ACCOUNTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STO_ACCOUNTS  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_ACCOUNTS.sql =========*** End ***
PROMPT ===================================================================================== 
