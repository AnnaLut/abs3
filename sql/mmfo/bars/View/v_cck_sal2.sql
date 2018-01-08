

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_SAL2.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_SAL2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_SAL2 ("DAT1", "DAT2", "BRANCH", "OB22", "ND", "CC_ID", "RNK", "DAOS", "TIP", "KV", "NLS", "NBS", "VOST", "DOS", "KOS", "IOST", "OKPO", "NMK", "ACC", "IR1", "IR2", "FIN", "OBS", "S080", "AIM", "VIDD", "PAWN") AS 
  SELECT i.dat1,
          i.dat2,
          i.branch,
          i.ob22,
          i.nd,
          i.cc_id,
          i.rnk,
          i.daos,
          i.tip,
          i.kv,
          i.nls,
          i.nbs,
          i.vost,
          i.dos,
          i.kos,
          i.iost,
          c.okpo,
          c.nmk,
          i.acc,
          i.ir1,
          i.ir2,
          NVL (i.fin, c.crisk) fin,
          i.obs,
          i.s080 s080,
          ad.aim,
          i.vidd,
          i.pawn
     FROM customer c,
--          specparam s,
          (SELECT nd, aim
             FROM cc_add
            WHERE adds = 0) ad,
          (SELECT d.dat1,
                  d.dat2,
                  e.branch,
                  e.fin23 fin,
                  e.obs23 obs,
                  e.kat23 s080,
                  e.vidd,
                  TO_NUMBER (NULL) pawn,
                  a.ob22,
                  e.nd,
                  e.cc_id,
                  e.rnk,
                  a.daos,
                  a.tip,
                  a.kv,
                  a.nls,
                  a.nbs,
                  a.acc,
                  acrn.fprocn (a.acc, 0, d.dat1) ir1,
                  acrn.fprocn (a.acc, 0, d.dat2) ir2,
                  fost (a.acc, d.dat1 - 1) / 100 vost,
                  fdos (a.acc, d.dat1, d.dat2) / 100 dos,
                  fkos (a.acc, d.dat1, d.dat2) / 100 kos,
                  fost (a.acc, d.dat2) / 100 iost
             FROM cc_deal e,
                  nd_acc n,
                  accounts a,
                  (SELECT NVL (
                             TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                      'dd.mm.yyyy'),
                             gl.bd)
                             dat1,
                          NVL (
                             TO_DATE (pul.get_mas_ini_val ('sFdat2'),
                                      'dd.mm.yyyy'),
                             gl.bd)
                             dat2
                     FROM DUAL) d
            WHERE     a.tip NOT IN ('SD ', 'SD8')
                  AND e.nd = n.nd
                  AND n.acc = a.acc
                  AND e.vidd IN (1, 2, 3)
           UNION ALL
           SELECT DISTINCT d.dat1,
                           d.dat2,
                           e.branch,
                           e.fin23 fin,
                           e.obs23 obs,
                           e.kat23 s080,
                           e.vidd,
                           w.pawn,
                           a.ob22,
                           e.nd,
                           e.cc_id,
                           e.rnk,
                           a.daos,
                           a.tip,
                           a.kv,
                           a.nls,
                           a.nbs,
                           a.acc,
                           TO_NUMBER (NULL) ir2,
                           TO_NUMBER (NULL) ir2,
                           fost (a.acc, d.dat1 - 1) / 100 vost,
                           fdos (a.acc, d.dat1, d.dat2) / 100 dos,
                           fkos (a.acc, d.dat1, d.dat2) / 100 kos,
                           fost (a.acc, d.dat2) / 100 iost
             FROM cc_deal e,
                  nd_acc n,
                  accounts a,
                  cc_accp p,
                  pawn_acc w,
                  (SELECT NVL (
                             TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                      'dd.mm.yyyy'),
                             gl.bd)
                             dat1,
                          NVL (
                             TO_DATE (pul.get_mas_ini_val ('sFdat2'),
                                      'dd.mm.yyyy'),
                             gl.bd)
                             dat2
                     FROM DUAL) d
            WHERE     e.nd = n.nd
                  AND n.acc = p.accs
                  AND p.acc = a.acc
                  AND a.acc = w.acc(+)
                  AND e.vidd IN (1, 2, 3)
           UNION ALL
           SELECT DISTINCT d.dat1,
                           d.dat2,
                           a.branch,
                           e.fin23 fin,
                           E.obs23 obs,
                           e.kat23 s080,
                           TO_NUMBER (NULL) vidd,
                           TO_NUMBER (NULL) pawn,
                           a.ob22,
                           e.nd,
                           e.ndoc,
                           a.rnk,
                           a.daos,
                           a.tip,
                           a.kv,
                           a.nls,
                           a.nbs,
                           a.acc,
                           acrn.fprocn (a.acc, 0, d.dat1) ir1,
                           acrn.fprocn (a.acc, 0, d.dat2) ir2,
                           fost (a.acc, d.dat1 - 1) / 100 vost,
                           fdos (a.acc, d.dat1, d.dat2) / 100 dos,
                           fkos (a.acc, d.dat1, d.dat2) / 100 kos,
                           fost (a.acc, d.dat2) / 100 iost
             FROM acc_over e,
                  accounts a,
                  int_accn i,
                  (SELECT NVL (
                             TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                      'dd.mm.yyyy'),
                             gl.bd)
                             dat1,
                          NVL (
                             TO_DATE (pul.get_mas_ini_val ('sFdat2'),
                                      'dd.mm.yyyy'),
                             gl.bd)
                             dat2
                     FROM DUAL) d
            WHERE e.acc = i.acc AND i.ID = 0
                  AND a.acc IN
                         (e.acc,
                          e.acco,
                          NVL (e.acc_9129, e.acc),
                          NVL (e.acc_8000, e.acc),
                          NVL (e.acc_2067, e.acc),
                          NVL (e.acc_2069, e.acc),
                          NVL (e.acc_2096, e.acc),
                          NVL (i.acra, e.acc))
           UNION ALL
           SELECT DISTINCT d.dat1,
                           d.dat2,
                           a.branch,
                           e.fin23 fin,
                           E.obs23 obs,
                           e.kat23 s080,
                           TO_NUMBER (NULL) vidd,
                           w.pawn,
                           a.ob22,
                           e.nd,
                           e.ndoc,
                           a.rnk,
                           a.daos,
                           a.tip,
                           a.kv,
                           a.nls,
                           a.nbs,
                           a.acc,
                           TO_NUMBER (NULL) ir2,
                           TO_NUMBER (NULL) ir2,
                           fost (a.acc, d.dat1 - 1) / 100 vost,
                           fdos (a.acc, d.dat1, d.dat2) / 100 dos,
                           fkos (a.acc, d.dat1, d.dat2) / 100 kos,
                           fost (a.acc, d.dat2) / 100 iost
             FROM acc_over e,
                  accounts a,
                  cc_accp p,
                  pawn_acc w,
                  (SELECT NVL (
                             TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                      'dd.mm.yyyy'),
                             gl.bd)
                             dat1,
                          NVL (
                             TO_DATE (pul.get_mas_ini_val ('sFdat2'),
                                      'dd.mm.yyyy'),
                             gl.bd)
                             dat2
                     FROM DUAL) d
            WHERE e.acc = p.accs AND p.acc = a.acc AND a.acc = w.acc(+)) i
    WHERE i.rnk = c.rnk --AND i.acc = s.acc(+)
      AND i.nd = ad.nd(+);

PROMPT *** Create  grants  V_CCK_SAL2 ***
grant SELECT                                                                 on V_CCK_SAL2      to BARSREADER_ROLE;
grant SELECT                                                                 on V_CCK_SAL2      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_SAL2      to RCC_DEAL;
grant SELECT                                                                 on V_CCK_SAL2      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_SAL2.sql =========*** End *** ===
PROMPT ===================================================================================== 
