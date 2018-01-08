

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCOUNTS_ALL_W4.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCOUNTS_ALL_W4 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCOUNTS_ALL_W4 ("ACC", "NLS", "NLSALT", "KV", "LCV", "DIG", "DENOM", "KF", "BRANCH", "TOBO", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "RNK", "NMS", "LIM", "OST", "OSTB", "OSTC", "OSTF", "OSTQ", "OSTX", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "OB22", "NOTIFIER_REF", "BDATE", "OPT") AS 
  SELECT /*+index(a i5_accounts)*/
         a.acc,
          a.nls,
          a.nlsalt,
          a.kv,
          v.lcv,
          v.dig,
          v.denom,
          a.kf,
          a.branch,
          a.tobo,
          a.nbs,
          a.nbs2,
          a.daos,
          a.dapp,
          a.isp,
          a.rnk,
          a.nms,
          a.lim,
          DECODE (a.dapp, b.bd, a.ostc + a.dos - a.kos, a.ostc) AS ost, -- остаток входящий
          a.ostb,
          a.ostc,                                         -- остаток исходящий
          a.ostf,
          a.ostq,
          a.ostx,
          DECODE (a.dapp, b.bd, a.dos, 0) dos,
          DECODE (a.dapp, b.bd, a.kos, 0) kos,
          DECODE (a.dapp, b.bd, a.dosq, 0) dosq,
          DECODE (a.dapp, b.bd, a.kosq, 0) kosq,
          a.pap,
          a.tip,
          a.vid,
          DECODE (a.dapp, b.bd, a.trcn, 0) trcn,
          a.mdate,
          a.dazs,
          a.sec,
          a.accc,
          a.blkd,
          a.blkk,
          a.pos,
          a.seci,
          a.seco,
          a.grp,
          a.ob22,
          a.notifier_ref,
          a.bdate,
          a.opt
     FROM accounts a,
          (SELECT bankdate_g bd FROM DUAL) b,
          tabval$global v
    WHERE     a.kv = v.kv
    and a.nbs = '2625';

PROMPT *** Create  grants  V_ACCOUNTS_ALL_W4 ***
grant SELECT                                                                 on V_ACCOUNTS_ALL_W4 to BARSREADER_ROLE;
grant SELECT                                                                 on V_ACCOUNTS_ALL_W4 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACCOUNTS_ALL_W4 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCOUNTS_ALL_W4.sql =========*** End 
PROMPT ===================================================================================== 
