

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_MES3.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_MES3 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_MES3 ("YYYYMM", "BRANCH", "OB22", "ND", "CC_ID", "RNK", "DAOS", "TIP", "KV", "NLS", "NBS", "VOST", "VOSTQ", "DOS", "DOSQ", "KOS", "KOSQ", "IOST", "IOSTQ") AS 
  SELECT b.yyyymm, e.branch, a.ob22, e.nd, e.cc_id, e.rnk, a.daos, a.tip,
          a.kv, a.nls, a.nbs,
          (m.ost + (m.dos + m.crdos) - (m.kos + m.crkos)) / 100 vost,
          (m.ostq + (m.dosq + m.crdosq) - (m.kosq + m.crkosq)) / 100 vostq,
          (m.dos + m.crdos) / 100 dos, (m.dosq + m.crdosq) / 100 dosq,
          (m.kos + m.crkos) / 100 kos, (m.kosq + m.crkosq) / 100 kosq,
          m.ost / 100 iost, m.ostq / 100 iostq
     FROM cc_deal e,
          nd_acc n,
          accounts a,
          accm_agg_monbals m,
          (SELECT TO_CHAR (caldt_date, 'yyyy.mm') yyyymm, caldt_id,
                  caldt_date
             FROM accm_calendar
            WHERE caldt_date =
                     TRUNC (NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                          'dd.mm.yyyy'
                                         ),
                                 gl.bd
                                ),
                            'MM'
                           )) b
    WHERE e.nd = n.nd
      AND n.acc = a.acc
      and e.rnk = a.rnk
      AND e.vidd IN (11, 12, 13)
      AND a.acc = m.acc
      AND m.caldt_id = b.caldt_id
   UNION ALL
   SELECT DISTINCT b.yyyymm, e.branch, a.ob22, e.nd, e.cc_id, e.rnk, a.daos,
                   a.tip, a.kv, a.nls, a.nbs,
                   (m.ost + (m.dos + m.crdos) - (m.kos + m.crkos)) / 100 vost,
                     (m.ostq + (m.dosq + m.crdosq) - (m.kosq + m.crkosq)
                     )
                   / 100 vostq,
                   (m.dos + m.crdos) / 100 dos,
                   (m.dosq + m.crdosq) / 100 dosq,
                   (m.kos + m.crkos) / 100 kos,
                   (m.kosq + m.crkosq) / 100 kosq, m.ost / 100 iost,
                   m.ostq / 100 iostq
              FROM cc_deal e,
                   nd_acc n,
                   accounts a,
                   cc_accp p,
                   accm_agg_monbals m,
                   (SELECT TO_CHAR (caldt_date, 'yyyy.mm') yyyymm, caldt_id,
                           caldt_date
                      FROM accm_calendar
                     WHERE caldt_date =
                              TRUNC
                                 (NVL
                                     (TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                               'dd.mm.yyyy'
                                              ),
                                      gl.bd
                                     ),
                                  'MM'
                                 )) b
             WHERE e.nd = n.nd
               AND n.acc = p.accs
               AND p.acc = a.acc
               AND e.vidd IN (11, 12, 33)
               AND a.acc = m.acc
               AND m.caldt_id = b.caldt_id;

PROMPT *** Create  grants  V_CCK_MES3 ***
grant SELECT                                                                 on V_CCK_MES3      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_MES3      to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_MES3.sql =========*** End *** ===
PROMPT ===================================================================================== 
