

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DELTAMIL_CTRL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DELTAMIL_CTRL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DELTAMIL_CTRL ("ACC", "BRANCH", "KV", "NLS", "OSTC", "OSTB", "DAPP", "FDAT", "SUMN", "SUMU", "PLAN", "DELTA") AS 
  SELECT q."ACC",
       q."BRANCH",
       q."KV",
       q."NLS",
       q."OSTC",
       q."OSTB",
       q."DAPP",
       q."FDAT",
       q."SUMN",
       q."SUMU",
       ROUND (sumn * 0.015, 0) Plan,
       ROUND (sumn * 0.015, 0) - sumu Delta
  FROM (  SELECT a.acc,
                 a.branch,
                 a.kv,
                 a.nls,
                 a.ostc,
                 a.ostb,
                 a.dapp,
                 o.fdat,
                 SUM (DECODE (o.tt,  '%%1', o.s,  'DU%', o.s,  0)) sumN,
                 SUM (DECODE (o.tt, 'MIL', o.s, 0)) sumu
            FROM bars.accounts a,
                 bars.customer c,
                 bars.opldok o,
                 bars.dpt_accounts da,
                 bars.dpt_deposit_clos dc
           WHERE ( (    o.tt IN ('%%1', 'DU%')
                    AND o.dk = 1
                    AND dc.action_id = 5
                    AND TRUNC (dc.when) = o.fdat
                    AND o.REF =
                           (SELECT MIN (REF) ref1
                              FROM bars.opldok
                             WHERE fdat = o.fdat AND acc = a.acc AND tt = '%%1'))
                  OR     o.tt = 'MIL'
                     AND o.dk = 0
                     AND dc.action_id = 5
                     AND TRUNC (dc.when) = o.fdat
                     AND o.REF =
                            (SELECT MIN (REF) ref1
                               FROM bars.opldok
                              WHERE     fdat = o.fdat
                                    AND acc = a.acc
                                    AND tt = 'MIL'))
                 AND (nbs = '2638'
                      OR nbs = '2628' AND ob22 NOT IN ('16', '19', '22', '23')
                      OR     nbs IN ('2608', '2618')
                         AND c.ise = '14200'
                         AND c.sed = '91')
                 AND a.acc = o.acc
                 AND c.rnk = a.rnk
                 AND a.acc = da.accid
                 AND da.dptid = dc.deposit_id
                 AND dc.action_id = 5
                 AND TRUNC (dc.when) = o.fdat
        GROUP BY a.acc,
                 a.branch,
                 a.dapp,
                 a.kv,
                 a.nls,
                 o.fdat,
                 a.ostc,
                 a.ostb) q
UNION ALL
SELECT q."ACC",
       q."BRANCH",
       q."KV",
       q."NLS",
       q."OSTC",
       q."OSTB",
       q."DAPP",
       q."FDAT",
       q."SUMN",
       q."SUMU",
       ROUND (sumn * 0.015, 0) Plan,
       ROUND (sumn * 0.015, 0) - sumu Delta
  FROM (  SELECT a.acc,
                 a.branch,
                 a.kv,
                 a.nls,
                 a.ostc,
                 a.ostb,
                 a.dapp,
                 o.fdat,
                 SUM (DECODE (o.tt,  '%%1', o.s,  'DU%', o.s,  0)) sumN,
                 SUM (DECODE (o.tt, 'MIL', o.s, 0)) sumu
            FROM bars.accounts a,
                 bars.customer c,
                 bars.opldok o,
                 bars.dpt_accounts da
           WHERE ( (o.tt IN ('%%1', 'DU%') AND o.dk = 1
                    OR o.tt = 'MIL' AND o.dk = 0))
                 AND (nbs = '2638'
                      OR nbs = '2628' AND ob22 NOT IN ('16', '19', '22', '23')
                      OR     nbs IN ('2608', '2618')
                         AND c.ise = '14200'
                         AND c.sed = '91')
                 AND a.acc = o.acc
                 AND c.rnk = a.rnk
                 AND a.acc = da.accid
                 AND NOT EXISTS
                            (SELECT 1
                               FROM bars.dpt_deposit_clos
                              WHERE     deposit_id = da.dptid
                                    AND action_id = 5
                                    AND TRUNC (when) = o.fdat)
        GROUP BY a.acc,
                 a.branch,
                 a.dapp,
                 a.kv,
                 a.nls,
                 o.fdat,
                 a.ostc,
                 a.ostb) q;

PROMPT *** Create  grants  V_DELTAMIL_CTRL ***
grant SELECT                                                                 on V_DELTAMIL_CTRL to BARSREADER_ROLE;
grant SELECT                                                                 on V_DELTAMIL_CTRL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DELTAMIL_CTRL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DELTAMIL_CTRL.sql =========*** End **
PROMPT ===================================================================================== 
