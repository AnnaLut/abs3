

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_PROBL_ON_DATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_PROBL_ON_DATE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_PROBL_ON_DATE ("BRANCH", "VIDD", "PROD", "RNK", "NMK", "ND", "CC_ID", "KV", "SDOG", "SDATE", "WDATE", "UADR", "ND_SUM", "BODY_NORM", "PERSENT_NORM", "BODY_DATE", "DATE_EXPIRED_BODY", "DAY_EXPIRED_BODY", "EXPIRED_BODY", "DOUBTFUL_BODY", "DAY_EXPIRED_PERSENT", "EXPIRED_PERSENTM31", "EXPIRED_PERSENTB31", "DOUBTFUL_PERSENT", "DUE_DATE", "SUM_PROPERTY") AS 
  (SELECT d.branch,
           d.vidd,
           d.prod,
           d.rnk,
           c.nmk,
           d.nd,
           d.cc_id,
           p.kv,
           d.sdog,
           TO_CHAR (d.sdate, 'dd-MON-yyyy') sdate,
           TO_CHAR (d.wdate, 'dd-MON-yyyy') wdate,
           uadr,
           gl.p_icurval (
              p.kv,
              d.sdog * 100,
              TO_DATE (pul.get_mas_ini_val ('SPAR'), 'dd-mm-yyyy'))
              nd_sum,
             gl.p_icurval (
                p.kv,
                p.ss,
                TO_DATE (pul.get_mas_ini_val ('SPAR'), 'dd-mm-yyyy'))
           / 100
              body_norm,
             gl.p_icurval (
                p.kv,
                p.sn,
                TO_DATE (pul.get_mas_ini_val ('SPAR'), 'dd-mm-yyyy'))
           / 100
              persent_norm,
           f_get_cck_spdat (
              TO_DATE (pul.get_mas_ini_val ('SPAR'), 'dd-mm-yyyy'),
              d.nd,
              0)
              body_date,
           f_get_cck_spdat (
              TO_DATE (pul.get_mas_ini_val ('SPAR'), 'dd-mm-yyyy'),
              d.nd,
              1)
              date_expired_body,
             TO_DATE (pul.get_mas_ini_val ('SPAR'), 'dd-mm-yyyy')
           - f_get_cck_spdat (
                TO_DATE (pul.get_mas_ini_val ('SPAR'), 'dd-mm-yyyy'),
                d.nd,
                0)
              day_expired_body,
             gl.p_icurval (
                p.kv,
                p.sp,
                TO_DATE (pul.get_mas_ini_val ('SPAR'), 'dd-mm-yyyy'))
           / 100
              expired_body,
             gl.p_icurval (
                p.kv,
                p.sl,
                TO_DATE (pul.get_mas_ini_val ('SPAR'), 'dd-mm-yyyy'))
           / 100
              doubtful_body,
             TO_DATE (pul.get_mas_ini_val ('SPAR'), 'dd-mm-yyyy')
           - f_get_cck_spdat (
                TO_DATE (pul.get_mas_ini_val ('SPAR'), 'dd-mm-yyyy'),
                d.nd,
                1)
              day_expired_persent,
             gl.p_icurval (
                p.kv,
                p.spn,
                TO_DATE (pul.get_mas_ini_val ('SPAR'), 'dd-mm-yyyy'))
           / 100
              expired_persentm31,
             gl.p_icurval (
                p.kv,
                p.spn_30,
                TO_DATE (pul.get_mas_ini_val ('SPAR'), 'dd-mm-yyyy'))
           / 100
              expired_persentb31,
             gl.p_icurval (
                p.kv,
                p.sln,
                TO_DATE (pul.get_mas_ini_val ('SPAR'), 'dd-mm-yyyy'))
           / 100
              doubtful_persent,
           cc_dat_sp (d.nd) due_date,
           (SELECT SUM (gl.p_icurval (aa.kv, aa.ostc, gl.bd))
              FROM accounts aa, cc_accp cp, pawn_acc pa
             WHERE     aa.acc = cp.acc
                   AND pa.acc = cp.acc
                   AND pa.pawn IN (15,
                                   23,
                                   25,
                                   30,
                                   31)
                   AND cp.accs = cd.accs)
              sum_property
      FROM cc_deal d,
           customer c,
           cc_add cd,
           (  SELECT a.kv,
                     n.nd,
                     -NVL (SUM (DECODE (a.tip, 'SS ', a.ostc, 0)), 0) ss,
                     -NVL (SUM (DECODE (a.tip, 'SN ', a.ostc, 0)), 0) sn,
                     -NVL (SUM (DECODE (a.tip, 'SP ', a.ostc, 0)), 0) sp,
                     -NVL (SUM (DECODE (a.tip, 'SL ', a.ostc, 0)), 0) sl,
                     -NVL (SUM (DECODE (a.tip, 'SPN', a.ostc - a.ost30, 0)), 0)
                        spn,
                     -NVL (SUM (DECODE (a.tip, 'SPN', a.ost30, 0)), 0) spn_30,
                     -NVL (SUM (DECODE (a.tip, 'SLN', a.ostc, 0)), 0) sln,
                     MAX (cw.VALUE) uadr
                FROM (SELECT kv,
                             acc,
                             tip,
                             rnk,
                             fost (
                                acc,
                                TO_DATE (pul.get_mas_ini_val ('SPAR'),
                                         'dd-mm-yyyy'))
                                ostc,
                             DECODE (
                                tip,
                                'SPN', -rez.f_get_rest_over_30 (
                                           acc,
                                           TO_DATE (
                                              pul.get_mas_ini_val ('SPAR'),
                                              'dd-mm-yyyy')),
                                0)
                                ost30
                        FROM accounts
                       WHERE     tip IN ('SS ',
                                         'SP ',
                                         'SL ',
                                         'SN ',
                                         'SPN',
                                         'SLN')
                             AND branch LIKE
                                       '%'
                                    || pul.get_mas_ini_val ('BRANCH')
                                    || '%'
                             AND kv =
                                    DECODE (
                                       pul.get_mas_ini_val ('KV'),
                                       '0', kv,
                                       TO_NUMBER (pul.get_mas_ini_val ('KV')))
                             AND nbs LIKE
                                       DECODE (pul.get_mas_ini_val ('VIDD'),
                                               '3', '22',
                                               '20')
                                    || '%') a,
                     nd_acc n,
                     customerw cw
               WHERE n.acc = a.acc AND a.rnk = cw.rnk(+) AND tag(+) = 'UADR'
            GROUP BY a.kv, n.nd) p
     WHERE     d.vidd IN (1,
                          2,
                          3,
                          11,
                          12,
                          13)
           AND d.nd = p.nd
           AND c.rnk = d.rnk
           AND d.nd = cd.nd
           AND (   p.sp <> 0
                OR p.spn <> 0
                OR p.spn_30 <> 0
                OR p.sl <> 0
                OR p.sln <> 0));

PROMPT *** Create  grants  V_CCK_PROBL_ON_DATE ***
grant SELECT                                                                 on V_CCK_PROBL_ON_DATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_PROBL_ON_DATE.sql =========*** En
PROMPT ===================================================================================== 
