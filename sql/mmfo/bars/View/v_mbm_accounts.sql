

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBM_ACCOUNTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBM_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBM_ACCOUNTS ("ACC", "KF", "NLS", "KV", "BRANCH", "NLSALT", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "NMS", "LIM", "OSTB", "OSTC", "OSTF", "OSTQ", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "OSTX", "RNK", "NOTIFIER_REF", "TOBO", "BDATE", "OPT", "OB22", "DAPPQ", "SEND_SMS", "OKPO", "LCV") AS 
  SELECT a."ACC",
          a."KF",
          a."NLS",
          a."KV",
          a."BRANCH",
          a."NLSALT",
          a."NBS",
          a."NBS2",
          a."DAOS",
          a."DAPP",
          a."ISP",
          a."NMS",
          a."LIM",
          a."OSTB",
          a."OSTC",
          a."OSTF",
          a."OSTQ",
          a."DOS",
          a."KOS",
          a."DOSQ",
          a."KOSQ",
          a."PAP",
          a."TIP",
          a."VID",
          a."TRCN",
          a."MDATE",
          a."DAZS",
          a."SEC",
          a."ACCC",
          a."BLKD",
          a."BLKK",
          a."POS",
          a."SECI",
          a."SECO",
          a."GRP",
          a."OSTX",
          a."RNK",
          a."NOTIFIER_REF",
          a."TOBO",
          a."BDATE",
          a."OPT",
          a."OB22",
          a."DAPPQ",
          a."SEND_SMS",
          c.OKPO,
          t.lcv
     FROM accounts a, customer c, tabval$global t
    WHERE a.kv = t.kv
        and a.RNK = c.RNK;

PROMPT *** Create  grants  V_MBM_ACCOUNTS ***
grant SELECT                                                                 on V_MBM_ACCOUNTS  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBM_ACCOUNTS.sql =========*** End ***
PROMPT ===================================================================================== 
