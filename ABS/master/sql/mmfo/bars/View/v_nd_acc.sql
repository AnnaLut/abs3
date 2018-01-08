

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ND_ACC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ND_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ND_ACC ("ND", "KV", "NLS", "ACC", "TIP", "OSTC", "RNK", "OB22", "ACCC") AS 
  SELECT   n.nd,
            a.kv,
            a.nls,
            a.acc,
            a.tip,
            a.ostc,
            a.rnk,
            ob22,
            a.accc
     FROM   nd_acc n, accounts a
    WHERE   a.dazs IS NULL AND a.acc = n.acc;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ND_ACC.sql =========*** End *** =====
PROMPT ===================================================================================== 
