

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RNK_ACC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RNK_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RNK_ACC ("RNK", "ND", "ACC", "NLS", "KV", "NBS", "DAOS", "DAPP", "ISP", "NMS", "OSTC", "PAP", "TIP", "MDATE", "DAZS", "ACCC") AS 
  SELECT   u.rnk,
            c.nd,
            a.acc,
            a.NLS,
            a.KV,
            a.NBS,
            a.DAOS,
            a.DAPP,
            a.ISP,
            a.NMS,
            a.OSTC,
            a.PAP,
            a.TIP,
            a.MDATE,
            a.DAZS,
            a.ACCC
     FROM   cust_acc u, saldo a, customer c
    WHERE   u.acc = a.acc AND u.rnk = c.rnk;

PROMPT *** Create  grants  V_RNK_ACC ***
grant SELECT                                                                 on V_RNK_ACC       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RNK_ACC       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RNK_ACC.sql =========*** End *** ====
PROMPT ===================================================================================== 
