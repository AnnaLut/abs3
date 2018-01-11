

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SAL_DRAPS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view SAL_DRAPS ***

  CREATE OR REPLACE FORCE VIEW BARS.SAL_DRAPS ("DAPP", "ACCC", "ACC", "NLS", "KV", "NMS", "GRP", "FDAT", "OSTF", "DOS", "KOS", "OST", "NBS", "ISP", "NLSALT", "DAZS", "APP", "TIP", "DAOS", "PAP", "RNK", "TOBO", "BRANCH", "KF") AS 
  SELECT s.fdat,
          a.accc,
          a.acc,
          a.nls,
          a.kv,
          a.nms,
          a.grp,
          s.fdat,
          s.ost + s.dos - s.kos, -- входящий остаток
          s.dos,
          s.kos,
          s.ost,                         -- исходящий остаток
          a.nbs,
          a.isp,
          a.nlsalt,
          a.dazs,
          s.fdat,
          a.tip,
          a.daos,
          a.pap,
          a.rnk,
          a.tobo,
          a.branch,
          a.kf
     FROM accounts a, snap_balances s
    WHERE a.acc = s.acc;

PROMPT *** Create  grants  SAL_DRAPS ***
grant SELECT                                                                 on SAL_DRAPS       to BARSREADER_ROLE;
grant SELECT                                                                 on SAL_DRAPS       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SAL_DRAPS.sql =========*** End *** ====
PROMPT ===================================================================================== 
