PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_ACCOUNTS.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  view V_CP_ACCOUNTS ***

create or replace force view V_CP_ACCOUNTS
( ACC, NLS, NLSALT, KV, LCV, DIG, DENOM, KF, BRANCH, TOBO, NBS, NBS2, DAOS, DAPP, ISP, RNK, NMS, LIM, OST, OSTB, OSTC, OSTF, OSTQ, OSTX, DOS, KOS, DOSQ, KOSQ, PAP, TIP, VID, TRCN, MDATE, DAZS, SEC, ACCC, BLKD, BLKK, POS, SECI, SECO, GRP, OB22, NOTIFIER_REF, BDATE, OPT, DAPPQ, INTACCN, FIO
) AS 
SELECT ACC,
       NLS,
       NLSALT,
       KV,
       LCV,
       DIG,
       DENOM,
       KF,
       BRANCH,
       TOBO,
       NBS,
       NBS2,
       DAOS,
       DAPP,
       ISP,
       RNK,
       NMS,
       LIM,
       OST,
       OSTB,
       OSTC,
       OSTF,
       OSTQ,
       OSTX,
       DOS,
       KOS,
       DOSQ,
       KOSQ,
       PAP,
       TIP,
       VID,
       TRCN,
       MDATE,
       DAZS,
       SEC,
       ACCC,
       BLKD,
       BLKK,
       POS,
       SECI,
       SECO,
       GRP,
       OB22,
       NOTIFIER_REF,
       BDATE,
       OPT,
       DAPPQ,
       INTACCN,
       FIO
  FROM V_CP_ACCOUNTS_LITE;

PROMPT *** Create  grants  V_CP_ACCOUNTS ***

grant SELECT on V_CP_ACCOUNTS to BARSREADER_ROLE;
grant SELECT on V_CP_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT on V_CP_ACCOUNTS to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_ACCOUNTS.sql =========*** End *** 
PROMPT ===================================================================================== 
