

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_MES3.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_MES3 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_MES3 ("YYYYMM", "BRANCH", "OB22", "ND", "CC_ID", "RNK", "DAOS", "TIP", "KV", "NLS", "NBS", "VOST", "VOSTQ", "DOS", "DOSQ", "KOS", "KOSQ", "IOST", "IOSTQ", "OKPO", "NMK", "ACC", "IR1", "IR2", "FIN", "OBS", "S080", "AIM", "VIDD", "PAWN") AS 
  SELECT i.YYYYMM,
          i.BRANCH,
          i.OB22,
          i.ND,
          i.CC_ID,
          i.RNK,
          i.daos,
          i.tip,
          i.KV,
          i.NLS,
          i.NBS,
          i.VOST,
          i.vostq,
          i.dos,
          i.dosq,
          i.kos,
          i.kosq,
          i.iost,
          i.iostq,
          c.OKPO,
          c.NMK,
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
          (                                                   /* йпедхрш тк */
           SELECT b.YYYYMM,
                  e.BRANCH,
                  e.fin23 fin,
                  e.obs23 obs,
                  e.kat23 s080,
                  e.vidd,
                  TO_NUMBER (NULL) pawn,
                  a.ob22,
                  e.ND,
                  e.CC_ID,
                  e.RNK,
                  a.daos,
                  a.TIP,
                  a.KV,
                  a.nls,
                  a.NBS,
                  a.acc,
                  acrn.fprocn (a.acc, 0, b.caldt_date) ir1,
                  acrn.fprocn (a.acc, 0, ADD_MONTHS (b.caldt_date, 1) - 1)
                     ir2,
                  (m.ost + (m.dos + m.crdos) - (m.kos + m.crkos)) / 100 vost,
                  (m.ostq + (m.dosq + m.crdosq) - (m.kosq + m.crkosq)) / 100 vostq,
                  (m.dos + m.crdos) / 100 dos,
                  (m.dosq + m.crdosq) / 100 dosq,
                  (m.kos + m.crkos) / 100 kos,
                  (m.kosq + m.crkosq) / 100 kosq,
                  m.ost / 100 iost,
                  m.ostq / 100 iostq
             FROM cc_deal e,
                  nd_acc n,
                  accounts a,
                  accm_agg_monbals m,
                  (SELECT TO_CHAR (caldt_date, 'yyyy.mm') yyyymm,
                          caldt_id,
                          caldt_date
                     FROM accm_calendar
                    WHERE caldt_date =
                             TRUNC (
                                NVL (
                                   TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                            'dd.mm.yyyy'),
                                   gl.bd),
                                'MM')) b
            WHERE     e.nd = n.nd
                  AND n.acc = a.acc
                  AND e.rnk = a.rnk
                  AND e.vidd IN (11, 12, 13)
                  AND a.acc = m.acc
                  AND m.caldt_id = b.caldt_id
           /* наеяоевемхе он йпедхрюл тк */
           UNION ALL
           SELECT DISTINCT b.YYYYMM,
                           e.BRANCH,
                           e.fin23 fin,
                           e.obs23 obs,
                           e.kat23 s080,
                           e.vidd,
                           w.pawn,
                           a.ob22,
                           e.ND,
                           e.CC_ID,
                           e.RNK,
                           a.daos,
                           a.TIP,
                           a.KV,
                           a.nls,
                           a.NBS,
                           a.acc,
                           TO_NUMBER (NULL) ir1,
                           TO_NUMBER (NULL) ir2,
                          (m.ost + (m.dos + m.crdos) - (m.kos + m.crkos)) / 100 vost,
                          (m.ostq + (m.dosq + m.crdosq) - (m.kosq + m.crkosq)) / 100 vostq,
                          (m.dos + m.crdos) / 100 dos,
                          (m.dosq + m.crdosq) / 100 dosq,
                          (m.kos + m.crkos) / 100 kos,
                          (m.kosq + m.crkosq) / 100 kosq,
                          m.ost / 100 iost,
                          m.ostq / 100 iostq
             FROM cc_deal e,
                  nd_acc n,
                  accounts a,
                  cc_accp p,
                  pawn_acc w,
                 accm_agg_monbals m,
                  (SELECT TO_CHAR (caldt_date, 'yyyy.mm') yyyymm,
                          caldt_id,
                          caldt_date
                     FROM accm_calendar
                    WHERE caldt_date =
                             TRUNC (
                                NVL (
                                   TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                            'dd.mm.yyyy'),
                                   gl.bd),
                                'MM')) b
            WHERE     e.nd = n.nd
                  AND n.acc = p.accs
                  AND p.acc = a.acc
                  AND e.vidd IN (11, 12, 33)
                  AND a.acc = m.acc
                  AND m.caldt_id = b.caldt_id) i
    WHERE i.rnk = c.rnk                                -- AND i.acc = s.acc(+)
                       AND i.nd = ad.nd(+);

PROMPT *** Create  grants  V_CCK_MES3 ***
grant SELECT                                                                 on V_CCK_MES3      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_MES3      to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_MES3.sql =========*** End *** ===
PROMPT ===================================================================================== 
