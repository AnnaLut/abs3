

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ND_ACCOUNTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ND_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ND_ACCOUNTS ("ND", "ACC", "NLS", "NLSALT", "KV", "KF", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "RNK", "NMS", "LIM", "OSTB", "OSTC", "OSTF", "OSTQ", "OSTX", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "TOBO", "LCV", "DIG", "OST", "DENOM", "BRANCH", "OB22", "FIO") AS 
  SELECT na.ND,
          a.ACC,
          a.NLS,
          a.NLSALT,
          a.KV,
          a.KF,
          a.NBS,
          a.NBS2,
          a.DAOS,
          a.DAPP,
          a.ISP,
          a.RNK,
          a.NMS,
          a.LIM,
          a.OSTB,
          s.ost ostc,
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
          (s.OST + s.DOS - s.KOS) OST,
          v.denom,
          a.BRANCH,
          a.OB22
          ,sb.fio
     FROM ACCOUNTS a,
          ND_ACC na,
          tabval$global v,
          sal_branch s,
          staff$base sb
    WHERE     a.ACC = na.ACC
          AND v.KV = a.KV
          AND a.ACC = s.ACC(+)
          AND s.FDAT = gl.bd
          and a.isp=sb.id
   UNION
   SELECT cp.ND,
          a.ACC,
          a.NLS,
          a.NLSALT,
          a.KV,
          a.KF,
          a.NBS,
          a.NBS2,
          a.DAOS,
          a.DAPP,
          a.ISP,
          a.RNK,
          a.NMS,
          a.LIM,
          a.OSTB,
          s.ost ostc,
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
          (s.OST + s.DOS - s.KOS) OST,
          v.denom,
          a.BRANCH,
          a.OB22,
          sb.fio
     FROM ACCOUNTS a,
          cc_accp cp,
          CC_add d,
          tabval$global v,
          sal_branch s,
          staff$base sb
    WHERE     cp.accs = d.accs
          AND a.ACC = cp.ACC
          AND v.KV = a.KV
          AND a.ACC = s.ACC(+)
          AND s.FDAT = gl.bd
          and a.isp=sb.id
;

PROMPT *** Create  grants  V_ND_ACCOUNTS ***
grant SELECT                                                                 on V_ND_ACCOUNTS   to BARSREADER_ROLE;
grant SELECT                                                                 on V_ND_ACCOUNTS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ND_ACCOUNTS   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ND_ACCOUNTS   to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_ND_ACCOUNTS   to WR_ND_ACCOUNTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ND_ACCOUNTS.sql =========*** End *** 
PROMPT ===================================================================================== 
