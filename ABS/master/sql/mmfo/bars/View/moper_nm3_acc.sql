

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MOPER_NM3_ACC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view MOPER_NM3_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.MOPER_NM3_ACC ("ACC", "KF", "NLS", "KV", "BRANCH", "NLSALT", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "NMS", "LIM", "OSTB", "OSTC", "OSTF", "OSTQ", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "OSTX", "RNK", "NOTIFIER_REF", "TOBO", "BDATE", "OPT", "OB22", "DAPPQ", "SEND_SMS") AS 
  SELECT "ACC","KF","NLS","KV","BRANCH","NLSALT","NBS","NBS2","DAOS","DAPP","ISP","NMS","LIM","OSTB","OSTC","OSTF","OSTQ","DOS","KOS","DOSQ","KOSQ","PAP","TIP","VID","TRCN","MDATE","DAZS","SEC","ACCC","BLKD","BLKK","POS","SECI","SECO","GRP","OSTX","RNK","NOTIFIER_REF","TOBO","BDATE","OPT","OB22","DAPPQ","SEND_SMS" FROM ACCOUNTS WHERE TIP = '90D';

PROMPT *** Create  grants  MOPER_NM3_ACC ***
grant SELECT                                                                 on MOPER_NM3_ACC   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MOPER_NM3_ACC.sql =========*** End *** 
PROMPT ===================================================================================== 
