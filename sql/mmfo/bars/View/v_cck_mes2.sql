

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_MES2.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_MES2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_MES2 ("YYYYMM", "BRANCH", "OB22", "ND", "CC_ID", "RNK", "DAOS", "TIP", "KV", "NLS", "NBS", "VOST", "VOSTQ", "DOS", "DOSQ", "KOS", "KOSQ", "IOST", "IOSTQ", "OKPO", "NMK", "ACC", "IR1", "IR2", "FIN", "OBS", "S080", "AIM", "VIDD", "PAWN") AS 
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
          i.s080  s080,
          ad.aim,
          i.vidd,
          i.pawn
     FROM customer c,
--          specparam s,
          (SELECT nd, aim
             FROM cc_add
            WHERE adds = 0) ad,
          (                                                   /* йпедхрш чк */
           SELECT m.YYYYMM,
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
                  acrn.fprocn (a.acc, 0, m.caldt_date) ir1,
                  acrn.fprocn (a.acc, 0, ADD_MONTHS (m.caldt_date, 1) - 1)
                     ir2,
                  m.vost,
                  m.vostq,
                  m.dOS,
                  m.dOSq,
                  m.KOS,
                  m.KOSq,
                  m.IOST,
                  m.IOSTq
             FROM cc_deal e,
                  nd_acc n,
                  accounts a,
                  v_accm_agg m
            WHERE     e.nd = n.nd
                  AND n.acc = a.acc
                  AND e.vidd IN (1, 2, 3)
                  AND a.acc = m.acc
           /* наеяоевемхе он йпедхрюл чк */
           UNION ALL
           SELECT DISTINCT m.YYYYMM,
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
                           m.vost,
                           m.vostq,
                           m.dOS,
                           m.dOSq,
                           m.KOS,
                           m.KOSq,
                           m.IOST,
                           m.IOSTq
             FROM cc_deal e,
                  nd_acc n,
                  accounts a,
                  cc_accp p,
                  pawn_acc w,
                  v_accm_agg m
            WHERE     e.nd = n.nd
                  AND n.acc = p.accs
                  AND p.acc = a.acc
                  AND a.acc = w.acc(+)
                  AND e.vidd IN (1, 2, 3)
                  AND a.acc = m.acc
           /* нбепдпютр  */
           UNION ALL
           SELECT DISTINCT
                  m.YYYYMM,
                  A.BRANCH,
                  e.fin23 fin,
                  E.obs23 obs,
                  e.kat23 s080,
                  TO_NUMBER (NULL) vidd,
                  TO_NUMBER (NULL) pawn,
                  a.ob22,
                  e.ND,
                  e.ndoc,
                  a.RNK,
                  a.daos,
                  a.TIP,
                  a.KV,
                  a.nls,
                  a.NBS,
                  a.acc,
                  acrn.fprocn (a.acc, 0, m.caldt_date) ir1,
                  acrn.fprocn (a.acc, 0, ADD_MONTHS (m.caldt_date, 1) - 1)
                     ir2,
                  m.vost,
                  m.vostq,
                  m.dOS,
                  m.dOSq,
                  m.KOS,
                  m.KOSq,
                  m.IOST,
                  m.IOSTq
             FROM ACC_OVER e,
                  accounts a,
                  INT_ACCN I,
                  v_accm_agg m
            WHERE e.ACC = I.ACC AND I.ID = 0 AND a.acc = m.acc
                  AND a.acc IN
                         (e.acc,
                          e.acco,
                          NVL (i.acra, e.acc),
                          NVL (e.acc_9129, e.acc),
                          NVL (e.acc_8000, e.acc),
                          NVL (e.acc_2067, e.acc),
                          NVL (e.acc_2069, e.acc),
                          NVL (e.acc_2096, e.acc))
           /* наеяоевемхе он нбепдпютр */
           UNION ALL
           SELECT DISTINCT m.YYYYMM,
                           A.BRANCH,
                           e.fin23 fin,
                           E.obs23 obs,
                           e.kat23 s080,
                           TO_NUMBER (NULL) vidd,
                           w.pawn,
                           a.ob22,
                           e.ND,
                           e.ndoc,
                           a.RNK,
                           a.daos,
                           a.TIP,
                           a.KV,
                           a.nls,
                           a.NBS,
                           a.acc,
                           TO_NUMBER (NULL) ir1,
                           TO_NUMBER (NULL) ir2,
                           m.vost,
                           m.vostq,
                           m.dOS,
                           m.dOSq,
                           m.KOS,
                           m.KOSq,
                           m.IOST,
                           m.IOSTq
             FROM acc_over e,
                  accounts a,
                  cc_accp p,
                  pawn_acc w,
                  v_accm_agg m
            WHERE     e.acc = p.accs
                  AND p.acc = a.acc
                  AND a.acc = w.acc(+)
                  AND a.acc = m.acc) i
    WHERE i.rnk = c.rnk -- AND i.acc = s.acc(+)
      AND i.nd = ad.nd(+);

PROMPT *** Create  grants  V_CCK_MES2 ***
grant SELECT                                                                 on V_CCK_MES2      to BARSREADER_ROLE;
grant SELECT                                                                 on V_CCK_MES2      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_MES2      to RCC_DEAL;
grant SELECT                                                                 on V_CCK_MES2      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_MES2.sql =========*** End *** ===
PROMPT ===================================================================================== 
