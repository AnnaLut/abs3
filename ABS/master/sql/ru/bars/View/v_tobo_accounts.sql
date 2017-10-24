

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TOBO_ACCOUNTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TOBO_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TOBO_ACCOUNTS ("ACC", "NLS", "NLSALT", "KV", "KF", "BRANCH", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "RNK", "NMS", "LIM", "OSTB", "OSTC", "OSTF", "OSTQ", "OSTX", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "TOBO", "LCV", "DIG", "DENOM", "OST", "OB22", "NOTIFIER_REF", "BDATE", "OPT") AS 
  SELECT a.ACC,
          a.NLS,
          a.NLSALT,
          a.KV,
          a.KF,
          a.BRANCH,
          a.NBS,
          a.NBS2,
          a.DAOS,
          a.DAPP,
          a.ISP,
          a.RNK,
          a.NMS,
          a.LIM,
          a.OSTB,
          s.OST AS OSTC,                                  -- остаток исходящий
          a.OSTF,
          a.OSTQ,
          a.OSTX,
          s.DOS,
          s.KOS,
          a.DOSQ,
          a.KOSQ,
          a.PAP,
          a.TIP,
          a.VID,
          a.TRCN,
          a.MDATE,
          a.DAZS,
          a.SEC,
          a.ACCC,
          a.BLKD,
          a.BLKK,
          a.POS,
          a.SECI,
          a.SECO,
          a.GRP,
          a.TOBO,
          v.LCV,
          v.DIG,
          v.DENOM,
          s.OSTF AS OST,
          a.OB22,
          a.NOTIFIER_REF,
          a.BDATE,
          a.OPT
     FROM ACCOUNTS a, tabval$global v, sal_branch s
    WHERE v.KV = a.KV AND a.acc = s.acc AND s.fdat = gl.bd;

PROMPT *** Create  grants  V_TOBO_ACCOUNTS ***
grant SELECT                                                                 on V_TOBO_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TOBO_ACCOUNTS to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_TOBO_ACCOUNTS to WR_CUSTLIST;
grant SELECT                                                                 on V_TOBO_ACCOUNTS to WR_TOBO_ACCOUNTS_LIST;
grant SELECT                                                                 on V_TOBO_ACCOUNTS to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TOBO_ACCOUNTS.sql =========*** End **
PROMPT ===================================================================================== 
