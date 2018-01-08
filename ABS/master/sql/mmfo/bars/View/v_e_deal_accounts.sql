

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_E_DEAL_ACCOUNTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_E_DEAL_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_E_DEAL_ACCOUNTS ("ACC", "BRANCH", "NLS", "KV", "NMS", "DOS", "KOS", "OSTC", "OSTB", "OSTF", "DAPP", "MDATE", "LIM", "NBS", "PAP", "TIP", "VID", "OB22", "ISP", "BLKD", "BLKK", "DAOS", "DAZS", "RNK") AS 
  (select a.acc,
           a.branch,
           a.nls,
           a.kv,
           a.nms,
           a.dos/100 as dos,
           a.kos/100 as kos,
           a.ostc/100 as ostc,
           a.ostb/100 as ostb,
           a.ostf/100 as ostf,
           a.dapp,
           a.mdate,
           a.lim,
           a.nbs,
           a.pap,
           a.tip,
           a.vid,
           a.ob22,
           a.isp,
           a.blkd,
           a.blkk,
           a.daos,
           a.dazs,
           a.rnk
      from accounts a, e_deal$base d
     where     (   a.acc = d.acc26
                or a.acc = d.acc36
                or a.acc = d.accd
                or a.acc = d.accp)
           and d.nd = to_number(pul.get('DEAL_ND')));

PROMPT *** Create  grants  V_E_DEAL_ACCOUNTS ***
grant SELECT                                                                 on V_E_DEAL_ACCOUNTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_E_DEAL_ACCOUNTS.sql =========*** End 
PROMPT ===================================================================================== 
