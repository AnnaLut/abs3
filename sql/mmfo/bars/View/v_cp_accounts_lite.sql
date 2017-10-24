

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_ACCOUNTS_LITE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_ACCOUNTS_LITE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_ACCOUNTS_LITE ("ACC", "NLS", "NLSALT", "KV", "LCV", "DIG", "DENOM", "KF", "BRANCH", "TOBO", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "RNK", "NMS", "LIM", "OST", "OSTB", "OSTC", "OSTF", "OSTQ", "OSTX", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "OB22", "NOTIFIER_REF", "BDATE", "OPT", "DAPPQ", "INTACCN", "FIO") AS 
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
          a.opt,
          a.dappq,
          acrn.fprocn (a.acc, DECODE (a.pap,  1, 0,  2, 1,  1), gl.bd)
             intaccn,sb.fio
     FROM accounts a,
          (SELECT bankdate_g bd FROM DUAL) b,
          saldo s,
          tabval$global v,
          cp_accounts ca,staff$base sb
    WHERE a.kv = v.kv AND a.acc = s.acc(+) AND a.acc = ca.cp_acc and a.isp=sb.id;

PROMPT *** Create  grants  V_CP_ACCOUNTS_LITE ***
grant SELECT                                                                 on V_CP_ACCOUNTS_LITE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_ACCOUNTS_LITE.sql =========*** End
PROMPT ===================================================================================== 
