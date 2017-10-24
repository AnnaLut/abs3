

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCOUNTS_RATN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCOUNTS_RATN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCOUNTS_RATN ("NLS", "KV", "OB22", "TIP", "VIDD", "ND", "CC_ID", "OSTC", "ABDAT", "AIR", "AIDU", "AFDAT", "EBDAT", "EIR", "EIDU", "EFDAT", "ACC", "RNK") AS 
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
          (SELECT c.nd
             FROM cc_deal c
            WHERE c.nd = n.nd)
             ND,
          (SELECT c.cc_id
             FROM cc_deal c
            WHERE c.nd = n.nd)
             cc_id,
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
                                 AND id IN (0, 1)))
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
                                 AND id IN (0, 1)))
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
                                 AND id IN (0, 1)))
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
                                 AND id IN (0, 1)))
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
                                 AND id = -2))
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
                                 AND id = -2))
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
                                 AND id = -2))
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
                                 AND id = -2))
             efdat,
          a.acc,
          a.rnk
     FROM accounts a, nd_acc n
    WHERE     nbs NOT LIKE '6%'
          AND nbs NOT LIKE '7%'
          AND dazs IS NULL
          AND a.acc = n.acc(+);

PROMPT *** Create  grants  V_ACCOUNTS_RATN ***
grant SELECT                                                                 on V_ACCOUNTS_RATN to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACCOUNTS_RATN to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCOUNTS_RATN.sql =========*** End **
PROMPT ===================================================================================== 
