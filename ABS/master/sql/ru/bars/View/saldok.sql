

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALDOK.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view SALDOK ***

  CREATE OR REPLACE FORCE VIEW BARS.SALDOK ("ACC", "KV", "NLS", "NLSALT", "OSTB", "OSTC", "DOS", "KOS", "LIM", "OSTF", "OSTQ", "DOSQ", "KOSQ", "NBS", "NBS2", "PAP", "DAOS", "DAPP", "DAZS", "ISP", "TIP", "VID", "NMS", "TRCN", "BLKD", "BLKK", "ACCC", "SEC", "TOBO", "KF", "BRANCH", "RNK") AS 
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

PROMPT *** Create  grants  SALDOK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDOK          to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDOK          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALDOK          to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SALDOK          to WR_ALL_RIGHTS;
grant SELECT                                                                 on SALDOK          to WR_DOCHAND;
grant SELECT                                                                 on SALDOK          to WR_DOC_INPUT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALDOK.sql =========*** End *** =======
PROMPT ===================================================================================== 
