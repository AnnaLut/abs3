

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_ACCRATN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_ACCRATN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_ACCRATN ("NLS", "KV", "OB22", "TIP", "VIDD", "ND", "CC_ID", "PROD", "SDATE", "WDATE", "OSTC", "ABDAT", "AIR", "AIDU", "AFDAT", "EBDAT", "EIR", "EIDU", "EFDAT", "ACC", "RNK") AS 
  SELECT a.nls NLS,
          a.kv KV,
          a.ob22 OB22,
          a.tip TIP,
          (SELECT (SELECT name
                     FROM cc_vidd
                    WHERE vidd = c.vidd)
             FROM cc_deal c
            WHERE c.nd = n.nd)
             vidd,
          d.nd ND,
          d.cc_id cc_id,
          d.prod prod,
          d.dsdate sdate,
          d.dwdate wdate,
          a.ostc / 100 OSTC,
          (SELECT ir.bdat
             FROM int_ratn_arc ir
            WHERE     ir.id IN (0, 1)
                  AND ir.vid IN ('I', 'U', 'D')
                  AND ir.acc = a.acc
                  AND ir.idupd =
                         (SELECT MAX (idupd)
                            FROM int_ratn_arc
                           WHERE     acc = a.acc
                                 AND vid IN ('I', 'U', 'D')
                                 AND id IN (0, 1)
                                 AND bdat =
                                        (SELECT MAX (bdat)
                                           FROM int_ratn
                                          WHERE     acc = a.acc
                                                AND bdat < TRUNC (SYSDATE))))
             abdat,
          (SELECT ir.ir
             FROM int_ratn_arc ir
            WHERE     ir.id IN (0, 1)
                  AND ir.vid IN ('I', 'U', 'D')
                  AND ir.acc = a.acc
                  AND ir.idupd =
                         (SELECT MAX (idupd)
                            FROM int_ratn_arc
                           WHERE     acc = a.acc
                                 AND vid IN ('I', 'U', 'D')
                                 AND id IN (0, 1)
                                 AND bdat =
                                        (SELECT MAX (bdat)
                                           FROM int_ratn
                                          WHERE     acc = a.acc
                                                AND bdat < TRUNC (SYSDATE))))
             air,
          (SELECT (SELECT fio
                     FROM staff$base
                    WHERE id = ir.idu)
                     fio
             FROM int_ratn_arc ir
            WHERE     ir.id IN (0, 1)
                  AND ir.vid IN ('I', 'U', 'D')
                  AND ir.acc = a.acc
                  AND ir.idupd =
                         (SELECT MAX (idupd)
                            FROM int_ratn_arc
                           WHERE     acc = a.acc
                                 AND vid IN ('I', 'U', 'D')
                                 AND id IN (0, 1)
                                 AND bdat =
                                        (SELECT MAX (bdat)
                                           FROM int_ratn
                                          WHERE     acc = a.acc
                                                AND bdat < TRUNC (SYSDATE))))
             aidu,
          (SELECT ir.fdat
             FROM int_ratn_arc ir
            WHERE     ir.id IN (0, 1)
                  AND ir.vid IN ('I', 'U', 'D')
                  AND ir.acc = a.acc
                  AND ir.idupd =
                         (SELECT MAX (idupd)
                            FROM int_ratn_arc
                           WHERE     acc = a.acc
                                 AND vid IN ('I', 'U', 'D')
                                 AND id IN (0, 1)
                                 AND bdat =
                                        (SELECT MAX (bdat)
                                           FROM int_ratn
                                          WHERE     acc = a.acc
                                                AND bdat < TRUNC (SYSDATE))))
             afdat,
          (SELECT ir.bdat
             FROM int_ratn_arc ir
            WHERE     ir.id = -2
                  AND ir.vid IN ('I', 'U', 'D')
                  AND ir.acc = a.acc
                  AND ir.idupd =
                         (SELECT MAX (idupd)
                            FROM int_ratn_arc
                           WHERE     acc = a.acc
                                 AND vid IN ('I', 'U', 'D')
                                 AND id = -2
                                 AND bdat =
                                        (SELECT MAX (bdat)
                                           FROM int_ratn
                                          WHERE     acc = a.acc
                                                AND bdat < TRUNC (SYSDATE))))
             ebdat,
          (SELECT ir.ir
             FROM int_ratn_arc ir
            WHERE     ir.id = -2
                  AND ir.vid IN ('I', 'U', 'D')
                  AND ir.acc = a.acc
                  AND ir.idupd =
                         (SELECT MAX (idupd)
                            FROM int_ratn_arc
                           WHERE     acc = a.acc
                                 AND vid IN ('I', 'U', 'D')
                                 AND id = -2
                                 AND bdat =
                                        (SELECT MAX (bdat)
                                           FROM int_ratn
                                          WHERE     acc = a.acc
                                                AND bdat < TRUNC (SYSDATE))))
             eir,
          (SELECT (SELECT fio
                     FROM staff$base
                    WHERE id = ir.idu)
                     fio
             FROM int_ratn_arc ir
            WHERE     ir.id = -2
                  AND ir.vid IN ('I', 'U', 'D')
                  AND ir.acc = a.acc
                  AND ir.idupd =
                         (SELECT MAX (idupd)
                            FROM int_ratn_arc
                           WHERE     acc = a.acc
                                 AND vid IN ('I', 'U', 'D')
                                 AND id = -2
                                 AND bdat =
                                        (SELECT MAX (bdat)
                                           FROM int_ratn
                                          WHERE     acc = a.acc
                                                AND bdat < TRUNC (SYSDATE))))
             eidu,
          (SELECT ir.fdat
             FROM int_ratn_arc ir
            WHERE     ir.id = -2
                  AND ir.vid IN ('I', 'U', 'D')
                  AND ir.acc = a.acc
                  AND ir.idupd =
                         (SELECT MAX (idupd)
                            FROM int_ratn_arc
                           WHERE     acc = a.acc
                                 AND vid IN ('I', 'U', 'D')
                                 AND id = -2
                                 AND bdat =
                                        (SELECT MAX (bdat)
                                           FROM int_ratn
                                          WHERE     acc = a.acc
                                                AND bdat < TRUNC (SYSDATE))))
             efdat,
          a.acc,
          a.rnk
     FROM accounts a, nd_acc n, cc_v d
    WHERE     a.nbs IN ('2203',
                         decode(NEWNBS.GET_STATE,0,'2202','2203'),
                        '2232',
                        '2233')
          AND a.dazs IS NULL
          AND a.OSTC <> 0
          AND a.acc = n.acc
          AND n.nd = d.nd;

PROMPT *** Create  grants  V_CC_ACCRATN ***
grant SELECT                                                                 on V_CC_ACCRATN    to BARSREADER_ROLE;
grant SELECT                                                                 on V_CC_ACCRATN    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CC_ACCRATN    to RCC_DEAL;
grant SELECT                                                                 on V_CC_ACCRATN    to START1;
grant SELECT                                                                 on V_CC_ACCRATN    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_ACCRATN.sql =========*** End *** =
PROMPT ===================================================================================== 
