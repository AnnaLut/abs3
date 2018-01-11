

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PAY1.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PAY1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PAY1 ("BRANCH", "ND", "CC_ID", "PROD", "SDATE", "WDATE", "NMK", "OKPO", "TELD", "TELW", "TELM", "KV", "FDAT", "GPK", "SPB", "TABN", "F_KAN", "PL_SS", "SS", "SN", "SP", "SPN", "SN8", "SI", "SF", "DAT_FS", "DAT_INSU", "DAT_ZAL") AS 
  SELECT BRANCH,
          ND,
          CC_ID,
          prod,
          SDATE,
          WDATE,
          NMK,
          OKPO,
          TELD,
          TELW,
          TELM,
          KV,
          FDAT,
          GPK,
          SPB,
          TABN,
          F_Kan,
          pl_SS,
          SS,
          SN,
          SP,
          SPN,
          SN8,
          SS + SN + SP + SPN SI,
          (CASE WHEN SS_ABS = 0 THEN SN + SP + SPN ELSE pl_SS + SN + SPN END)
             SF,
          Dat_FS,
          Dat_Insu,
          Dat_ZAL
     FROM (SELECT d.BRANCH,
                  d.ND,
                  d.CC_ID,
                  SUBSTR (d.prod, 1, 6) prod,
                  d.SDATE,
                  d.WDATE,
                  c.NMK,
                  c.OKPO,
                  p.TELD,
                  p.TELW,
                  (SELECT SUBSTR (VALUE, 1, 14)
                     FROM customerw
                    WHERE rnk = c.rnk AND TRIM (tag) = 'MPNO')
                     TELM,
                  a.KV,
                  t.FDAT,
                  DECODE (a.vid, 4, 'An', 'Kl') GPK,
                  SUBSTR ( (SELECT txt
                              FROM nd_txt
                             WHERE nd = d.nd AND tag = 'WORKB'),
                          1,
                          10)
                     SPB,
                  SUBSTR ( (SELECT txt
                              FROM nd_txt
                             WHERE nd = d.nd AND tag = 'WORKN'),
                          1,
                          10)
                     TABN,
                    NVL (
                       cck_plan_sum_pog (
                          d.nd,
                          a.KV,
                          a.vid,
                          a.ostx,
                          NVL (GetGlobalOption ('CC_PAY_S'), '0')),
                       0)
                  / 100
                     pl_SS,
                  DECODE (SUBSTR ( (SELECT TRIM (txt)
                                      FROM nd_txt
                                     WHERE nd = d.nd AND tag = 'FLAGS'),
                                  1,
                                  1),
                          '0', 'Так',
                          'Нi ')
                     F_Kan,
                  (CASE
                      WHEN NVL (
                                (SELECT -SUM (fost (aa.acc, z.DAT))
                                   FROM nd_acc nn, accounts aa
                                  WHERE     nn.nd = d.nd
                                        AND nn.acc = aa.acc
                                        AND aa.tip = 'SS ')
                              / 100,
                              0) = 0
                      THEN
                         0
                      ELSE
                         NVL (  (SELECT sumg
                                   FROM cc_lim l
                                  WHERE nd = d.nd AND l.fdat = t.FDAT)
                              / 100,
                              0)
                   END)
                     SS,
                  NVL (
                       (SELECT -SUM (fost (aa.acc, z.DAT))
                          FROM nd_acc nn, accounts aa
                         WHERE     nn.nd = d.nd
                               AND nn.acc = aa.acc
                               AND aa.tip = 'SS ')
                     / 100,
                     0)
                     SS_ABS,
                  NVL (
                       (SELECT -SUM (fost (aa.acc, z.DAT))
                          FROM nd_acc nn, accounts aa
                         WHERE     nn.nd = d.nd
                               AND nn.acc = aa.acc
                               AND aa.tip = 'SN ')
                     / 100,
                     0)
                     SN,
                  NVL (
                       (SELECT -SUM (fost (aa.acc, z.DAT))
                          FROM nd_acc nn, accounts aa
                         WHERE     nn.nd = d.nd
                               AND nn.acc = aa.acc
                               AND aa.tip = 'SP ')
                     / 100,
                     0)
                     SP,
                  NVL (
                       (SELECT -SUM (fost (aa.acc, z.DAT))
                          FROM nd_acc nn, accounts aa
                         WHERE     nn.nd = d.nd
                               AND nn.acc = aa.acc
                               AND aa.tip = 'SPN')
                     / 100,
                     0)
                     SPN,
                  NVL (
                       (SELECT -SUM (
                                   gl.p_icurval (aa.KV,
                                                 fost (aa.acc, z.DAT),
                                                 z.DAT))
                          FROM nd_acc nn, accounts aa
                         WHERE     nn.nd = d.nd
                               AND nn.acc = aa.acc
                               AND aa.tip = 'SN8')
                     / 100,
                     0)
                     SN8,
                  (SELECT MAX (fdat) FDAT
                     FROM cc_sob
                    WHERE     otm = 6
                          AND psys = 7
                          AND fdat <= z.DAT
                          AND nd = d.nd)
                     Dat_FS,
                  (SELECT MAX (fdat) FDAT
                     FROM cc_sob
                    WHERE     otm = 6
                          AND psys = 9
                          AND fdat <= z.DAT
                          AND nd = d.nd)
                     Dat_Insu,
                  (SELECT MAX (fdat) FDAT
                     FROM cc_sob
                    WHERE     otm = 6
                          AND psys = 1
                          AND fdat <= z.DAT
                          AND nd = d.nd)
                     Dat_ZAL
             FROM cc_deal d,
                  customer c,
                  person p,
                  nd_acc n,
                  v_gl a,
                  /* (SELECT NVL (
                             TO_DATE (:sFdat1,
                                      'dd.mm.yyyy'),
                             gl.bd)
                             DAT
                     FROM DUAL) z,
                  (  SELECT nd, MIN (fdat) FDAT
                       FROM cc_lim
                      WHERE fdat >=
                               NVL (
                                  TO_DATE (:sFdat1,
                                           'dd.mm.yyyy'),
                                  gl.bd)
                   GROUP BY nd) t */
                  (SELECT NVL (
                             TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                      'dd.mm.yyyy'),
                             gl.bd)
                             DAT
                     FROM DUAL) z,
                  (  SELECT nd, MIN (fdat) FDAT
                       FROM cc_lim
                      WHERE fdat >=
                               NVL (
                                  TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                           'dd.mm.yyyy'),
                                  gl.bd)
                   GROUP BY nd) t
            WHERE     d.vidd IN (11, 12, 13)
                  AND d.rnk = c.rnk
                  AND c.rnk = p.rnk
                  AND d.nd = n.nd
                  AND n.acc = a.acc
                  AND a.tip = 'LIM'
                  AND d.nd = t.nd(+)
                  AND fost (a.acc, z.DAT) < 0);

PROMPT *** Create  grants  V_PAY1 ***
grant SELECT                                                                 on V_PAY1          to BARSREADER_ROLE;
grant SELECT                                                                 on V_PAY1          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PAY1          to RCC_DEAL;
grant SELECT                                                                 on V_PAY1          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PAY1.sql =========*** End *** =======
PROMPT ===================================================================================== 
