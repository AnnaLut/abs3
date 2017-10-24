

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_USER_ACCOUNTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_USER_ACCOUNTS ("ACC", "NLS", "KV", "NBS", "NMS", "DAOS", "DAPP", "MDATE", "DAZS", "ISP", "RNK", "LIM", "OSTX", "OSTB", "OSTC", "OSTF", "DOS", "KOS", "PAP", "BLKD", "BLKK", "POS") AS 
  select  a.acc, a.nls, a.kv, a.nbs, a.nms,
        a.daos, a.dapp, a.mdate, a.dazs,
        a.isp, a.rnk,
        a.lim, a.ostx,
        a.ostb, a.ostc, a.ostf, a.dos, a.kos,
        a.pap,
        a.blkd, a.blkk,
        a.pos
from barsaq.aq_subscribers_acc q, bars.accounts a
where q.name=USER and q.acc=a.acc
 ;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_USER_ACCOUNTS.sql =========*** End 
PROMPT ===================================================================================== 
