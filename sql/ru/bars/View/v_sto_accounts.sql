

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_ACCOUNTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_ACCOUNTS ("ACC", "RNK", "NLS", "NMS", "KV", "BRANCH", "DAOS", "OSTC", "TIP") AS 
  SELECT a.acc,
          a.rnk,
          a.nls,
          a.nms,
          a.kv,
          a.branch,
          a.daos,
          a.ostc,
          a.tip
     FROM accounts a
    WHERE     a.nbs IN ('2625', '2620')
          AND a.kv = 980
          AND a.tip LIKE 'W4%'
          AND a.dazs IS NULL
          AND a.kf = sys_context('bars_context', 'user_mfo');

PROMPT *** Create  grants  V_STO_ACCOUNTS ***
grant SELECT                                                                 on V_STO_ACCOUNTS  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_ACCOUNTS.sql =========*** End ***
PROMPT ===================================================================================== 
