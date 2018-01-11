

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_ERR_REL_ACC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_ERR_REL_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_ERR_REL_ACC ("NLS", "TIP", "KV", "ND", "RNK_ND", "RNK_ACC", "VIDD", "SOS", "DAZS", "ACC") AS 
  SELECT x.NLS,
          x.TIP,
          x.KV,
          d.ND,
          d.rnk RNK_ND,
          x.rnk RNK_ACC,
          d.VIDD,
          d.SOS,
          x.DAZS,
          x.ACC
     FROM nd_acc n,
          cc_deal d,
          (  SELECT aa.acc,
                    aa.kv,
                    aa.nls,
                    aa.rnk,
                    aa.tip,
                    aa.dazs,
                    COUNT (*) kol_nd
               FROM accounts aa, nd_acc nn, cc_deal dd
              WHERE     dd.vidd IN (1,
                                    2,
                                    3,
                                    11,
                                    12,
                                    13)
                    AND dd.nd = nN.ND
                    AND aa.acc = nn.acc
                    AND (   aa.nbs LIKE '20%'
                         OR aa.nbs LIKE '22%'
                         OR aa.nbs LIKE '357%')
           GROUP BY aa.acc,
                    aa.kv,
                    aa.nls,
                    aa.rnk,
                    aa.tip,
                    aa.dazs
             HAVING COUNT (*) > 1) x
    WHERE n.acc = x.acc AND n.nd = d.nd;

PROMPT *** Create  grants  V_CCK_ERR_REL_ACC ***
grant SELECT                                                                 on V_CCK_ERR_REL_ACC to BARSREADER_ROLE;
grant SELECT                                                                 on V_CCK_ERR_REL_ACC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_ERR_REL_ACC to START1;
grant SELECT                                                                 on V_CCK_ERR_REL_ACC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_ERR_REL_ACC.sql =========*** End 
PROMPT ===================================================================================== 
