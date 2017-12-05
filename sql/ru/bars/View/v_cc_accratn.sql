CREATE OR REPLACE FORCE VIEW BARS.V_CC_ACCRATN
(
   NLS,
   KV,
   OB22,
   TIP,
   VIDD,
   ND,
   CC_ID,
   PROD,
   SDATE,
   WDATE,
   OSTC,
   ABDAT,
   AIR,
   AIDU,
   AFDAT,
   EBDAT,
   EIR,
   EIDU,
   EFDAT,
   ACC,
   RNK
)
AS
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

COMMENT ON TABLE BARS.V_CC_ACCRATN IS 'Інформація про встановлену процентну ставку по рахунку КД';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.NLS IS 'Рахунок клієнта';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.KV IS 'Код валюти';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.OB22 IS 'ОБ22';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.TIP IS 'Тип рахунку';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.VIDD IS 'Вид кредитування';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.ND IS 'Референс договору';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.CC_ID IS 'Номер договору';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.PROD IS 'Продукт кредитування';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.SDATE IS 'Дата початку договору';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.WDATE IS 'Дата закінчення договору';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.OSTC IS 'Залишок по рахунку';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.ABDAT IS 'Дата початку дії ставки';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.AIR IS 'Процентна ставка';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.AIDU IS 'Користувач що вносив зміни';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.AFDAT IS 'Дата внесення змін';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.EBDAT IS 'Дата початку дії ефективної ставки';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.EIR IS 'Процентна ставка ефективна';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.EIDU IS 'Користувач що вносив зміни';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.EFDAT IS 'Дата внесення змін';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.ACC IS 'ACC';

COMMENT ON COLUMN BARS.V_CC_ACCRATN.RNK IS 'РНК';




GRANT SELECT ON BARS.V_CC_ACCRATN TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.V_CC_ACCRATN TO START1;