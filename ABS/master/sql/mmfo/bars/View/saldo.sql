

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALDO.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view SALDO ***

  CREATE OR REPLACE FORCE VIEW BARS.SALDO ("ACC", "KF", "BRANCH", "OB22", "KV", "NLS", "NLSALT", "OSTB", "OSTC", "OSTX", "DOS", "KOS", "LIM", "OSTF", "OSTQ", "DOSQ", "KOSQ", "NBS", "NBS2", "PAP", "DAOS", "DAPP", "DAZS", "ISP", "TIP", "VID", "MDATE", "NMS", "TRCN", "BLKD", "BLKK", "ACCC", "POS", "SECI", "SECO", "SEC", "GRP", "TOBO", "RNK", "DAPPQ", "OPT", "BDATE", "NOTIFIER_REF") AS 
  SELECT acc
       , kf
       , branch
       , ob22
       , kv
       , nls
       , nlsalt
       , ostb
       , ostc
       , OSTX
       , dos
       , kos
       , lim
       , ostf
       , ostq
       , dosq
       , kosq
       , nbs
       , nbs2
       , pap
       , daos
       , dapp
       , dazs
       , isp
       , tip
       , vid
       , mdate
       , nms
       , trcn
       , blkd
       , blkk
       , accc
       , pos
       , SECI
       , SECO
       , sec
       , GRP
       , tobo
       , rnk
       , dappq
       , OPT
       , BDATE
       , NOTIFIER_REF
    FROM accounts;

PROMPT *** Create  grants  SALDO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDO           to ABS_ADMIN;
grant SELECT                                                                 on SALDO           to BARS010;
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDO           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALDO           to DPT;
grant SELECT                                                                 on SALDO           to DPT_ROLE;
grant SELECT                                                                 on SALDO           to FOREX;
grant SELECT                                                                 on SALDO           to JBOSS_USR;
grant SELECT                                                                 on SALDO           to KLBX;
grant SELECT                                                                 on SALDO           to RPBN001;
grant SELECT                                                                 on SALDO           to START1;
grant SELECT                                                                 on SALDO           to TOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SALDO           to WR_ALL_RIGHTS;
grant SELECT                                                                 on SALDO           to WR_CREDIT;
grant SELECT                                                                 on SALDO           to WR_CREPORTS;
grant SELECT                                                                 on SALDO           to WR_CUSTLIST;
grant SELECT                                                                 on SALDO           to WR_DEPOSIT_U;
grant SELECT                                                                 on SALDO           to WR_DOCHAND;
grant SELECT                                                                 on SALDO           to WR_DOCVIEW;
grant SELECT                                                                 on SALDO           to WR_DOC_INPUT;
grant SELECT                                                                 on SALDO           to WR_ND_ACCOUNTS;
grant SELECT                                                                 on SALDO           to WR_TOBO_ACCOUNTS_LIST;
grant SELECT                                                                 on SALDO           to WR_USER_ACCOUNTS_LIST;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALDO.sql =========*** End *** ========
PROMPT ===================================================================================== 
