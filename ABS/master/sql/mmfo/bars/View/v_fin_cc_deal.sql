

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FIN_CC_DEAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FIN_CC_DEAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FIN_CC_DEAL ("TIP", "VIDD", "RNK", "ND", "CC_ID", "SDATE", "WDATE", "BRANCH", "FIN23", "OBS23", "KAT23", "K23", "KV", "SOS", "PROD") AS 
  
   SELECT 'CCK' AS tip,
          c.vidd,
          c.rnk,
          c.nd,
          c.cc_id,
          c.sdate,
          c.wdate,
          c.branch,
          c.fin23,
          c.obs23,
          c.kat23,
          c.k23,
          d.kv,
          c.sos,
          c.prod
     FROM cc_deal c, cc_add d
    WHERE     c.nd = d.nd
          AND EXISTS
                 (SELECT 1
                    FROM nd_acc n, accounts a
                   WHERE     n.nd = c.nd
                         AND n.acc = a.acc
                         
                         AND tip = 'LIM'
                         AND nls LIKE '8999%'
                         AND (dazs IS NULL OR dazs > SYSDATE - 31))
   UNION ALL                                                       -- гарантії
   SELECT 'GAR' AS tip,
          c.vidd,
          c.rnk,
          c.nd,
          c.cc_id,
          c.sdate,
          c.wdate,
          c.branch,
          c.fin23,
          c.obs23,
          c.kat23,
          c.k23,
          980 AS kv,
          c.sos,
          c.prod
     FROM cc_deal c
    WHERE vidd IN (29, 39, 19)
   UNION ALL                     -- Все що не ввійшло в модуля (по номеру асс)
   SELECT 'ACC' AS tip,
          NULL AS vidd,
          a.rnk,
          a.acc AS nd,
          a.nls AS cc_id,
          a.daos,
          a.mdate,
          a.branch,
          c.fin,
          c.obs,
          c.kat,
          c.k,
          a.kv AS kv,
          NULL AS sos,
          a.nbs AS prod
     FROM ACC_FIN_OBS_KAT c, accounts a
    WHERE     a.nbs IN ('9020')
          AND a.acc = c.acc
          AND NOT EXISTS
                 (SELECT 1
                    FROM nd_acc
                   WHERE acc = a.acc)
          AND (a.dazs IS NULL OR a.dazs > SYSDATE - 31)
   UNION ALL                                                       -- гарантії
   SELECT 'OVR' AS tip,
          c.vidd,
          c.rnk,
          c.nd,
          c.cc_id,
          c.sdate,
          c.wdate,
          c.branch,
          c.fin23,
          c.obs23,
          c.kat23,
          c.k23,
          980 AS kv,
          c.sos,
          c.prod
     FROM cc_deal c
    WHERE vidd IN (110)
   UNION ALL                                                      -- овердрафт
   SELECT 'OVR' AS tip,
          2600 AS vidd,
          a.rnk,
          o.nd,
          ndoc AS cc_id,
          datd AS sdate,
          datd2 AS wdate,
          a.branch,
          o.fin23,
          o.obs23,
          o.kat23,
          o.k23,
          a.kv,
          NULL AS sos,
          a.nbs AS prod
     FROM acc_over o, accounts a
        WHERE o.acc = a.acc AND o.acc = o.acco AND 1 = 0
   UNION ALL                                                            -- БПК
   SELECT 'BPK' AS tip,
          2625 AS vidd,
          a.rnk,
          o.nd,
          NULL AS cc_id,
          NULL AS sdate,
          NULL AS wdate,
          a.branch,
          o.fin23,
          o.obs23,
          o.kat23,
          o.k23,
          a.kv,
          NULL AS sos,
          a.nbs AS prod
     FROM bpk_acc o, accounts a
    WHERE     (   acc_9129 IS NOT NULL
               OR acc_ovr IS NOT NULL
               OR acc_3570 IS NOT NULL
               OR acc_2208 IS NOT NULL
               OR acc_2207 IS NOT NULL
               OR acc_3579 IS NOT NULL
               OR acc_2209 IS NOT NULL)
          AND o.acc_pk = a.acc
          AND (a.dazs IS NULL OR a.dazs > SYSDATE - 31)
          AND 1 = 0
   UNION ALL                                                        -- опенвей
   SELECT 'OW4' AS tip,
          2625 AS vidd,
          a.rnk,
          o.nd,
          NULL AS cc_id,
          daos AS sdate,
          NULL AS wdate,
          a.branch,
          o.fin23,
          o.obs23,
          o.kat23,
          o.k23,
          a.kv,
          NULL AS sos,
          a.nbs AS prod
     FROM w4_acc o, accounts a   
    WHERE /*(   acc_9129 IS NOT NULL -- В рамках проставляння ВКР для кредитної фабрики прибрано умову наявності хоч одного рахунку
           OR acc_ovr IS NOT NULL
           OR acc_3570 IS NOT NULL
           OR acc_2208 IS NOT NULL
           OR acc_2207 IS NOT NULL
           OR acc_3579 IS NOT NULL
           OR acc_2209 IS NOT NULL)
      AND*/
          o.acc_pk = a.acc AND (a.dazs IS NULL OR a.dazs > SYSDATE - 31);

PROMPT *** Create  grants  V_FIN_CC_DEAL ***
grant DELETE,SELECT,UPDATE                                                   on V_FIN_CC_DEAL   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FIN_CC_DEAL.sql =========*** End *** 
PROMPT ===================================================================================== 
