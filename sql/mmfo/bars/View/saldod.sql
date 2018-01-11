

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALDOD.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view SALDOD ***

  CREATE OR REPLACE FORCE VIEW BARS.SALDOD ("ACC", "KV", "NLS", "NLSALT", "OSTB", "OSTC", "DOS", "KOS", "LIM", "OSTF", "OSTQ", "DOSQ", "KOSQ", "NBS", "NBS2", "PAP", "DAOS", "DAPP", "DAZS", "ISP", "TIP", "VID", "NMS", "TRCN", "BLKD", "BLKK", "ACCC", "SEC", "TOBO", "KF", "BRANCH", "RNK") AS 
  SELECT acc,
          kv,
          nls,
          nlsalt,
          0,
          0,
          dos,
          kos,
          0,
          0,
          0,
          0,
          0,
          nbs,
          nbs2,
          pap,
          daos,
          dapp,
          dazs,
          isp,
          tip,
          vid,
          nms,
          trcn,
          blkd,
          blkk,
          accc,
          sec,
          tobo,
          KF,
          BRANCH,
          rnk
     FROM accounts;

PROMPT *** Create  grants  SALDOD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDOD          to ABS_ADMIN;
grant SELECT                                                                 on SALDOD          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDOD          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALDOD          to PYOD001;
grant SELECT                                                                 on SALDOD          to START1;
grant SELECT                                                                 on SALDOD          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SALDOD          to WR_ALL_RIGHTS;
grant SELECT                                                                 on SALDOD          to WR_DOCHAND;
grant SELECT                                                                 on SALDOD          to WR_DOC_INPUT;
grant SELECT                                                                 on SALDOD          to WR_IMPEXP;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALDOD.sql =========*** End *** =======
PROMPT ===================================================================================== 
