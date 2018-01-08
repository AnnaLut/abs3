

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GLS080.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GLS080 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GLS080 ("ACC", "KF", "NLS", "KV", "BRANCH", "NLSALT", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "NMS", "LIM", "OSTB", "OSTC", "OSTF", "OSTQ", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "OSTX", "RNK", "NOTIFIER_REF", "TOBO", "BDATE", "OPT", "OB22", "DAPPQ", "SEND_SMS", "S080", "NKD", "RZ", "COUNTRY") AS 
  SELECT a."ACC",a."KF",a."NLS",a."KV",a."BRANCH",a."NLSALT",a."NBS",a."NBS2",a."DAOS",a."DAPP",a."ISP",a."NMS",a."LIM",a."OSTB",a."OSTC",a."OSTF",a."OSTQ",a."DOS",a."KOS",a."DOSQ",a."KOSQ",a."PAP",a."TIP",a."VID",a."TRCN",a."MDATE",a."DAZS",a."SEC",a."ACCC",a."BLKD",a."BLKK",a."POS",a."SECI",a."SECO",a."GRP",a."OSTX",a."RNK",a."NOTIFIER_REF",a."TOBO",a."BDATE",a."OPT",a."OB22",a."DAPPQ",a."SEND_SMS", S.S080, S.NKD , DECODE (NVL (c.codcagent, 1),  '2', 2,  '4', 2,  '6', 2,  1) RZ, c.country
   FROM accounts a, specparam s, customer c
   WHERE a.acc = s.acc(+) AND a.rnk = c.rnk;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GLS080.sql =========*** End *** =====
PROMPT ===================================================================================== 
