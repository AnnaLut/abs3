

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALB_DRAPS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view SALB_DRAPS ***

  CREATE OR REPLACE FORCE VIEW BARS.SALB_DRAPS ("ACCC", "ACC", "NLS", "KV", "NMS", "FDAT", "DOS", "KOS", "OST", "NBS", "ISP", "NLSALT", "DAZS", "DAPP", "TIP", "TOBO") AS 
  SELECT a.accc,
          a.acc,
          a.nls,
          a.kv,
          a.nms,
          s.fdat,
          s.dosq,
          s.kosq,
          s.ostq,
          a.nbs,
          a.isp,
          a.nlsalt,
          a.dazs,
          s.fdat,
          a.tip,
          a.tobo
     FROM accounts a, snap_balances s
    WHERE     a.kv <> 980
          AND a.acc = s.acc;

PROMPT *** Create  grants  SALB_DRAPS ***
grant SELECT                                                                 on SALB_DRAPS      to BARSREADER_ROLE;
grant SELECT                                                                 on SALB_DRAPS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALB_DRAPS.sql =========*** End *** ===
PROMPT ===================================================================================== 
