

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GL.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GL ("ACC", "KF", "NLS", "KV", "BRANCH", "NLSALT", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "NMS", "LIM", "OSTB", "OSTC", "OSTF", "OSTQ", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "OSTX", "RNK", "NOTIFIER_REF", "TOBO", "BDATE", "OPT", "OB22", "S080") AS 
  SELECT a.ACC,
          a.KF,
          a.NLS,
          a.KV,
          a.BRANCH,
          a.NLSALT,
          a.NBS,
          a.NBS2,
          a.DAOS,
          a.DAPP,
          a.ISP,
          a.NMS,
          a.LIM,
          a.OSTB,
          a.OSTC,
          a.OSTF,
          a.OSTQ,
          a.DOS,
          a.KOS,
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
          a.OSTX,
          a.RNK,
          a.NOTIFIER_REF,
          a.TOBO,
          a.BDATE,
          a.OPT,
          a.OB22,
          S.S080
     FROM accounts a,specparam s
     where a.acc=s.acc (+);

PROMPT *** Create  grants  V_GL ***
grant SELECT                                                                 on V_GL            to BARSUPL;
grant SELECT                                                                 on V_GL            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_GL            to START1;
grant SELECT                                                                 on V_GL            to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_GL            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GL.sql =========*** End *** =========
PROMPT ===================================================================================== 
