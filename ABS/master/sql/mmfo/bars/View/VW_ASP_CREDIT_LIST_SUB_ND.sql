CREATE OR REPLACE FORCE VIEW BARS.VW_ASP_CREDIT_LIST_SUB_ND
(
   DPLAN,
   FDAT,
   NPP,
   ACC,
   TIP,
   KV,
   NLS,
   NMS,
   OSTB,
   OSTC,
   ND,
   NDG
)
AS
   SELECT DPLAN,
          FDAT,
          NPP,
          ACC,
          TIP,
          KV,
          NLS,
          NMS,
          OSTB,
          OSTC,
          ND,
          ndg
     FROM (SELECT TO_DATE (NULL) dplan,
                  TO_DATE (NULL) FDAT,
                  TO_NUMBER (NULL) npp,
                  a.acc,
                  a.tip,
                  a.kv,
                  a.nls,
                  a.nms,
                  a.ostb / 100 ostb,
                  a.ostc / 100 ostc,
                  d.nd,
                  d.ndg
             FROM accounts a, nd_acc n, cc_deal d
            WHERE     a.acc = n.acc
                  AND d.nd = n.nd
                  AND d.rnk = a.rnk
                  AND (   a.nbs < '4' AND a.ostb < 0
                       OR a.tip IN ('ISG', 'SDI', 'SN8'))
                  AND NOT EXISTS
                         (SELECT 1
                            FROM cc_trans
                           WHERE acc = a.acc)
           UNION ALL
           SELECT t.d_plan,
                  t.FDAT,
                  TO_NUMBER (NULL) npp,
                  a.acc,
                  a.tip,
                  a.kv,
                  a.nls,
                  a.nms,
                  a.ostb / 100 ostb,
                  - (t.sv - t.sz) / 100 ostc,
                  d.nd,
                  d.ndg
             FROM accounts a,
                  nd_acc n,
                  cc_trans t,
                  cc_deal d
            WHERE /*n.nd = :nd
                                          and */
                 a.acc = n.acc
                  AND d.nd = n.nd
                  AND d.rnk = a.rnk
                  AND (a.nbs < '4' AND a.ostb < 0)
                  AND a.acc = t.acc
                  AND t.d_fakt IS NULL
           UNION ALL
           SELECT TO_DATE (NULL),
                  TO_DATE (NULL),
                  TO_NUMBER (NULL) npp,
                  a.acc,
                  a.tip,
                  a.kv,
                  a.nls,
                  a.nms,
                  a.ostb / 100 ostb,
                  (a.ostc / 100 + ct.ss / 100) ostc,
                  d.nd,
                  d.ndg
             FROM accounts a,
                  nd_acc n,
                  cc_deal d,
                  (  SELECT acc, SUM (sv - sz) ss
                       FROM cc_trans
                      WHERE d_fakt IS NULL
                   GROUP BY acc) ct
            WHERE /*n.nd = :nd
                                          and*/
                 a.acc = n.acc
                  AND d.nd = n.nd
                  AND d.rnk = a.rnk
                  AND EXISTS
                         (SELECT 1
                            FROM cc_trans
                           WHERE acc = a.acc)
                  AND a.acc = ct.acc
                  AND (a.ostc / 100 + ct.ss / 100) > 0);


GRANT SELECT ON BARS.VW_ASP_CREDIT_LIST_SUB_ND TO BARS_ACCESS_DEFROLE;