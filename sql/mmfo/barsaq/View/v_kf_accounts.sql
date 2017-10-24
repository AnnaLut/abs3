

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_KF_ACCOUNTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KF_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_KF_ACCOUNTS ("KF", "ACC", "NLS", "NLSALT", "KV", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "NMS", "LIM", "OSTB", "OSTC", "OSTF", "OSTQ", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "OSTX", "RNK", "TOBO", "DAPPQ") AS 
  select
   a.kf,
   a.acc, a.nls, a.nlsalt,
   a.kv, a.nbs, a.nbs2,
   a.daos, a.dapp, a.isp,
   a.nms, a.lim, a.ostb,
   a.ostc, a.ostf, a.ostq,
   a.dos, a.kos, a.dosq,
   a.kosq, a.pap, a.tip,
   a.vid, a.trcn, a.mdate,
   a.dazs, a.sec, a.accc,
   a.blkd, a.blkk, a.pos,
   a.seci, a.seco, a.grp,
   a.ostx, a.rnk, a.tobo,
   a.dappq
from bars.accounts a;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_KF_ACCOUNTS.sql =========*** End **
PROMPT ===================================================================================== 
