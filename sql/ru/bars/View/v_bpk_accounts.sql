

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_ACCOUNTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_ACCOUNTS ("ACC", "KF", "NLS", "KV", "BRANCH", "NLSALT", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "NMS", "LIM", "OSTB", "OSTC", "OSTF", "OSTQ", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "OSTX", "RNK", "NOTIFIER_REF", "TOBO", "BDATE", "OPT") AS 
  select a."ACC",a."KF",a."NLS",a."KV",a."BRANCH",a."NLSALT",a."NBS",a."NBS2",a."DAOS",a."DAPP",a."ISP",a."NMS",a."LIM",a."OSTB",a."OSTC",a."OSTF",a."OSTQ",a."DOS",a."KOS",a."DOSQ",a."KOSQ",a."PAP",a."TIP",a."VID",a."TRCN",a."MDATE",a."DAZS",a."SEC",a."ACCC",a."BLKD",a."BLKK",a."POS",a."SECI",a."SECO",a."GRP",a."OSTX",a."RNK",a."NOTIFIER_REF",a."TOBO",a."BDATE",a."OPT"
  from bpk_acc o, accounts a
 where o.acc_pk = a.acc;

PROMPT *** Create  grants  V_BPK_ACCOUNTS ***
grant SELECT                                                                 on V_BPK_ACCOUNTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BPK_ACCOUNTS  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_ACCOUNTS.sql =========*** End ***
PROMPT ===================================================================================== 
