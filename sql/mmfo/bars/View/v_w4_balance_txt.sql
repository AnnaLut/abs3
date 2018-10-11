CREATE OR REPLACE VIEW V_W4_BALANCE_TXT AS
SELECT BRANCH,
           NMK,
           ACC,
           NLS,
           DAT,
           kv,
           A_PK_OST,
           W_PK_OST,
           DELTA_PK_OST,
           A_OVR_OST,
           W_OVR_OST,
           DELTA_OVR_OST,
           A2207_OST,
           W2207_OST,
           DELTA_2207_OST,
           A2208_OST,
           W2208_OST,
           DELTA_2208_OST,
           A2209_OST,
           W2209_OST,
           DELTA_2209_OST,
           A2625D_OST,
           W2625D_OST,
           DELTA_2625D_OST,
           A2627_OST,
           W2627_OST,
           DELTA_2627_OST,
           A2627X_OST,
           W2627X_OST,
           DELTA_2627X_OST,
           A2628_OST,
           W2628_OST,
           DELTA_2628_OST,
           A3570_OST,
           W3570_OST,
           DELTA_3570_OST,
           A3579_OST,
           W3579_OST,
           DELTA_3579_OST,
           A9129_OST,
           W9129_OST,
           DELTA_9129_OST,
           AAR_OST,
           WAR_OST,
           DELTA_AR_OST,
           WPEN,
           acc_close
     FROM (SELECT t.branch,
                  t.nmk,
                  t.acc,
                  t.nls,
                  t.dat,
                  t.kv,
                  a_pk_ost,
                  NVL (w_pk_ost, 0) w_pk_ost,
                  a_pk_ost - NVL (w_pk_ost, 0) delta_pk_ost,
                  a_ovr_ost,
                  NVL (w_ovr_ost, 0) w_ovr_ost,
                  a_ovr_ost - NVL (w_ovr_ost, 0) delta_ovr_ost,
                  a2207_ost,
                  NVL (w2207_ost, 0) w2207_ost,
                  a2207_ost - NVL (w2207_ost, 0) delta_2207_ost,
                  a2208_ost,
                  NVL (w2208_ost, 0) w2208_ost,
                  a2208_ost - NVL (w2208_ost, 0) delta_2208_ost,
                  a2209_ost,
                  NVL (w2209_ost, 0) w2209_ost,
                  a2209_ost - NVL (w2209_ost, 0) delta_2209_ost,
                  a2625d_ost,
                  NVL (w2625d_ost, 0) w2625d_ost,
                  a2625d_ost - NVL (w2625d_ost, 0) delta_2625d_ost,
                  a2627_ost,
                  NVL (w2627_ost, 0) w2627_ost,
                  a2627_ost - NVL (w2627_ost, 0) delta_2627_ost,
                  a2627x_ost,
                  NVL (w2627x_ost, 0) w2627x_ost,
                  a2627x_ost - NVL (w2627x_ost, 0) delta_2627x_ost,
                  a2628_ost,
                  NVL (w2628_ost, 0) w2628_ost,
                  a2628_ost - NVL (w2628_ost, 0) delta_2628_ost,
                  a3570_ost,
                  NVL (w3570_ost, 0) w3570_ost,
                  a3570_ost - NVL (w3570_ost, 0) delta_3570_ost,
                  a3579_ost,
                  NVL (w3579_ost, 0) w3579_ost,
                  a3579_ost - NVL (w3579_ost, 0) delta_3579_ost,
                  a9129_ost,
                  NVL (w9129_ost, 0) w9129_ost,
                  a9129_ost - NVL (w9129_ost, 0) delta_9129_ost,
                  aar_ost,
                  NVL (war_ost, 0) war_ost,
                  aar_ost - NVL (war_ost, 0) delta_ar_ost, nvl(WPEN,0) wpen,
                  case when dazs is null then 0 else 1 end acc_close
             FROM (SELECT a.branch,
                          c.nmk,
                          a.acc,
                          a.nls,
                          a.kv,
                          d.dat,
                          fost (a.acc, d.dat) / 100 a_pk_ost,
                            DECODE (o.acc_ovr,
                                    NULL, 0,
                                    fost (o.acc_ovr, d.dat))
                          / 100
                             a_ovr_ost,
                            DECODE (o.acc_2207,
                                    NULL, 0,
                                    fost (o.acc_2207, d.dat))
                          / 100
                             a2207_ost,
                            DECODE (o.acc_2208,
                                    NULL, 0,
                                    fost (o.acc_2208, d.dat))
                          / 100
                             a2208_ost,
                            DECODE (o.acc_2209,
                                    NULL, 0,
                                    fost (o.acc_2209, d.dat))
                          / 100
                             a2209_ost,
                            DECODE (o.acc_2625d,
                                    NULL, 0,
                                    fost (o.acc_2625d, d.dat))
                          / 100
                             a2625d_ost,
                            DECODE (o.acc_2627,
                                    NULL, 0,
                                    fost (o.acc_2627, d.dat))
                          / 100
                             a2627_ost,
                            DECODE (o.acc_2627x,
                                    NULL, 0,
                                    fost (o.acc_2627x, d.dat))
                          / 100
                             a2627x_ost,
                            DECODE (o.acc_2628,
                                    NULL, 0,
                                    fost (o.acc_2628, d.dat))
                          / 100
                             a2628_ost,
                            DECODE (o.acc_3570,
                                    NULL, 0,
                                    fost (o.acc_3570, d.dat))
                          / 100
                             a3570_ost,
                            DECODE (o.acc_3579,
                                    NULL, 0,
                                    fost (o.acc_3579, d.dat))
                          / 100
                             a3579_ost,
                            DECODE (o.acc_9129,
                                    NULL, 0,
                                    fost (o.acc_9129, d.dat))
                          / 100
                             a9129_ost,
                          TO_NUMBER (NVL (w.VALUE, 0))*-1 aar_ost,
                          a.dazs
                     FROM w4_acc o,
                          accounts a,
                          customer c,
                          (SELECT *
                             FROM accountsw
                            WHERE tag = 'W4_ARSUM') w,
                          (SELECT NVL (TO_DATE (val, 'dd.mm.yyyy'), bankdate)
                                     dat
                             FROM ow_params
                            WHERE par = 'CNGDATE') d
                    WHERE     o.acc_pk = a.acc
                          AND a.tip LIKE 'W4%'
                          AND a.branch LIKE
                                 SYS_CONTEXT ('bars_context',
                                              'user_branch_mask')
                          AND a.rnk = c.rnk
                          AND a.acc = w.acc(+)) t
                  LEFT JOIN
                  (  SELECT acc_pk acc,
                            SUM (CASE
                                    WHEN nbs_ow IN ('2520',
                                                    '2541',
                                                    '2542',
                                                    '2605',
                                                    '2625',
                                                    '2655',
                                                    '3550',
                                                    '3551')
                                    THEN
                                       ost
                                    ELSE
                                       0
                                 END)
                               w_pk_ost,
                            SUM (
                               CASE
                                  WHEN nbs_ow IN ('NLS_2202', 'NLS_2203')
                                  THEN
                                     ost
                                  ELSE
                                     0
                               END)
                               w_ovr_ost,
                            SUM (
                               CASE
                                  WHEN nbs_ow IN ('NLS_2207') THEN ost
                                  ELSE 0
                               END)
                               w2207_ost,
                            SUM (
                               CASE
                                  WHEN nbs_ow IN ('NLS_2208') THEN ost
                                  ELSE 0
                               END)
                               w2208_ost,
                            SUM (
                               CASE
                                  WHEN nbs_ow IN ('NLS_2209') THEN ost
                                  ELSE 0
                               END)
                               w2209_ost,
                            SUM (
                               CASE
                                  WHEN nbs_ow IN ('NLS_2625D') THEN ost
                                  ELSE 0
                               END)
                               w2625d_ost,
                            SUM (
                               CASE
                                  WHEN nbs_ow IN ('NLS_2627') THEN ost
                                  ELSE 0
                               END)
                               w2627_ost,
                            SUM (
                               CASE
                                  WHEN nbs_ow IN ('NLS_2627X') THEN ost
                                  ELSE 0
                               END)
                               w2627x_ost,
                            SUM (
                               CASE
                                  WHEN nbs_ow IN ('NLS_2628') THEN ost
                                  ELSE 0
                               END)
                               w2628_ost,
                            SUM (
                               CASE
                                  WHEN nbs_ow IN ('NLS_3570') THEN ost
                                  ELSE 0
                               END)
                               w3570_ost,
                            SUM (
                               CASE
                                  WHEN nbs_ow IN ('NLS_3579') THEN ost
                                  ELSE 0
                               END)
                               w3579_ost,
                            SUM (
                               CASE
                                  WHEN nbs_ow IN ('NLS_9129') THEN ost
                                  ELSE 0
                               END)
                               w9129_ost,
                            SUM (
                               CASE
                                  WHEN nbs_ow IN ('NLS_TRANS') THEN ost
                                  ELSE 0
                               END)
                               war_ost,
                                SUM (
                               CASE
                                  WHEN nbs_ow IN ('NLS_639709') THEN ost
                                  ELSE 0
                               END)
                               wpen
                       FROM ow_cng_data_txt
                      WHERE acc_pk IS NOT NULL
                   GROUP BY acc_pk) w
                     ON w.acc = t.acc)
    WHERE    delta_pk_ost <> 0
          OR delta_ovr_ost <> 0
          OR delta_2207_ost <> 0
          OR delta_2208_ost <> 0
          OR delta_2209_ost <> 0
          OR delta_2625d_ost <> 0
          OR delta_2627_ost <> 0
          OR delta_2627x_ost <> 0
          OR delta_2628_ost <> 0
          OR delta_3570_ost <> 0
          OR delta_3579_ost <> 0
          OR delta_9129_ost <> 0
          OR delta_ar_ost <> 0;
