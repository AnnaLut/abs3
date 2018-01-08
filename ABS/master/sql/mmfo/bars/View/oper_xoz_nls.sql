

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPER_XOZ_NLS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view OPER_XOZ_NLS ***

  CREATE OR REPLACE FORCE VIEW BARS.OPER_XOZ_NLS ("ACC", "KF", "NLS", "KV", "BRANCH", "NLSALT", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "NMS", "LIM", "OSTB", "OSTC", "OSTF", "OSTQ", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "OSTX", "RNK", "NOTIFIER_REF", "TOBO", "BDATE", "OPT", "OB22", "DAPPQ", "SEND_SMS") AS 
  SELECT "ACC","KF","NLS","KV","BRANCH","NLSALT","NBS","NBS2","DAOS","DAPP","ISP","NMS","LIM","OSTB","OSTC","OSTF","OSTQ","DOS","KOS","DOSQ","KOSQ","PAP","TIP","VID","TRCN","MDATE","DAZS","SEC","ACCC","BLKD","BLKK","POS","SECI","SECO","GRP","OSTX","RNK","NOTIFIER_REF","TOBO","BDATE","OPT","OB22","DAPPQ","SEND_SMS" FROM bars.accounts  WHERE  tip IN ('XOZ', 'W4X')  AND dazs IS NULL    AND kv = 980  AND branch LIKE SYS_CONTEXT ('bars_context', 'user_branch') || '%';

PROMPT *** Create  grants  OPER_XOZ_NLS ***
grant SELECT                                                                 on OPER_XOZ_NLS    to BARSREADER_ROLE;
grant SELECT                                                                 on OPER_XOZ_NLS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPER_XOZ_NLS    to START1;
grant SELECT                                                                 on OPER_XOZ_NLS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPER_XOZ_NLS.sql =========*** End *** =
PROMPT ===================================================================================== 
