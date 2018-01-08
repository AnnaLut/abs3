

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_DU.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_DU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_DU ("DAT", "KV", "BRANCH", "ND", "CC_ID", "SDATE", "WDATE", "RNK", "SDOG", "S080", "DAT1", "DAT2", "ACC8", "OST8", "ARJK", "OKPO", "NMK", "R013", "S580") AS 
  SELECT NVL (TO_DATE (pul.Get_Mas_Ini_Val ('sFdat1'), 'dd-mm-yyyy'), gl.BD),
          x.kv,
          x.branch,
          x.nd,
          x.cc_id,
          x.sdate,
          x.wdate,
          x.rnk,
          x.sdog,
          x.s080,
          TO_DATE (x.DINDU, 'dd/mm/yyyy') DINDU,
          TO_DATE (x.DO_DU, 'dd/mm/yyyy') DO_DU,
          x.acc,
          - (x.ostc) / 100,
          TO_NUMBER (x.ARJK) ARJK,
          c.OKPO,
          c.NMK,
          x.r013,
          x.s580
     FROM customer c,
          (SELECT d.branch,
                  d.nd,
                  d.cc_id,
                  d.sdate,
                  d.wdate,
                  d.rnk,
                  d.sdog,
                  a.kv,
                  s.s080,
                  r013,
                  s580,
                  a.acc,
                  fost (
                     a.acc,
                     NVL (
                        TO_DATE (pul.Get_Mas_Ini_Val ('sFdat1'),
                                 'dd-mm-yyyy'),
                        gl.BD))
                     OSTC,
                  cck_app.get_nd_txt (d.nd, 'DINDU') DINDU,
                  cck_app.get_nd_txt (d.nd, 'DO_DU') DO_DU,
                  cck_app.get_nd_txt (d.nd, 'ARJK') ARJK
             FROM cc_deal d,
                  nd_acc n,
                  specparam s,
                  accounts a
            WHERE     d.vidd IN (11, 12, 13)
                  AND d.sos >= 10
                  AND d.sos < 14
                  AND d.nd = n.nd
                  AND n.acc = a.acc
                  AND a.tip = 'LIM'
                  AND a.acc = s.acc(+)) x
    WHERE     x.rnk = c.rnk
          AND (   x.s080 IN ('1', '2')
               OR x.DINDU IS NOT NULL AND x.DO_DU IS NULL);

PROMPT *** Create  grants  V_CCK_DU ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CCK_DU        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CCK_DU        to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_DU.sql =========*** End *** =====
PROMPT ===================================================================================== 
