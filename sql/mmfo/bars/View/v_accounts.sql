

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCOUNTS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCOUNTS ("ACC", "NLS", "NLSALT", "KV", "LCV", "DIG", "DENOM", "KF", "BRANCH", "TOBO", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "RNK", "NMS", "LIM", "OST", "OSTB", "OSTC", "OSTF", "OSTQ", "OSTX", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "OB22", "NOTIFIER_REF", "BDATE", "OPT", "FIO", "INTACCN") AS 
  SELECT "ACC",
          "NLS",
          "NLSALT",
          "KV",
          "LCV",
          "DIG",
          "DENOM",
          "KF",
          "BRANCH",
          "TOBO",
          "NBS",
          "NBS2",
          "DAOS",
          "DAPP",
          "ISP",
          "RNK",
          "NMS",
          "LIM",
          "OST",
          "OSTB",
          "OSTC",
          "OSTF",
          "OSTQ",
          "OSTX",
          "DOS",
          "KOS",
          "DOSQ",
          "KOSQ",
          "PAP",
          "TIP",
          "VID",
          "TRCN",
          "MDATE",
          "DAZS",
          "SEC",
          "ACCC",
          "BLKD",
          "BLKK",
          "POS",
          "SECI",
          "SECO",
          "GRP",
          "OB22",
          "NOTIFIER_REF",
          "BDATE",
          "OPT",
          "FIO",
		  "INTACCN"
     FROM v_tobo_accounts_lite;

PROMPT *** Create  grants  V_ACCOUNTS ***
grant SELECT                                                                 on V_ACCOUNTS      to BARSREADER_ROLE;
grant SELECT                                                                 on V_ACCOUNTS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACCOUNTS      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ACCOUNTS      to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_ACCOUNTS      to WR_DEPOSIT_U;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCOUNTS.sql =========*** End *** ===
PROMPT ===================================================================================== 
