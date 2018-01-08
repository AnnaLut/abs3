

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/GL_NBU23_REZ_ACC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view GL_NBU23_REZ_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.GL_NBU23_REZ_ACC ("FDAT", "BRANCH", "KV", "NLS", "NBS", "TIP", "ACC", "RNK", "OST", "BV", "DEL", "OSTQ", "BVQ", "DELQ") AS 
  SELECT "FDAT",
          "BRANCH",
          "KV",
          "NLS",
          "NBS",
          "TIP",
          "ACC",
          "RNK",
          "OST",
          "BV",
          "DEL",
          "OSTQ",
          "BVQ",
          "DELQ"
     FROM (SELECT TO_DATE (pul.Get_Mas_Ini_Val ('sFdat1'), 'dd.mm.yyyy') FDAT,
                  q.BRANCH,
                  q.KV,
                  q.nls,
                  q.nbs,
                  q.tip,
                  q.acc,
                  q.rnk,
                  q.OST,
                  r.BV,
                  (q.OST + NVL (r.BV, 0)) del,
                  q.ostq,
                  r.bvq,
                  (q.OSTq + NVL (r.BVq, 0)) delq
             FROM (SELECT acc, bv, bvq
                     FROM nbu23_rez
                    WHERE fdat =
                             TO_DATE (pul.Get_Mas_Ini_Val ('sFdat1'),
                                      'dd.mm.yyyy')) r,
                  (SELECT a.tobo BRANCH,
                          a.KV,
                          a.nls,
                          a.nbs,
                          a.tip,
                          a.acc,
                          a.rnk,
                          m.ostq / 100 OSTq,
                          m.ost / 100 OST
                     FROM kl_f3_29 k,
                          accounts a,
                          (SELECT mm.acc,
                                  (mm.ostq - mm.crdosq + mm.crkosq) OSTQ,
                                  (mm.ost - mm.crdos + mm.crkos) OST
                             FROM ACCM_AGG_MONBALS mm, accm_calendar c
                            WHERE mm.caldt_id = c.caldt_id
                                  AND c.caldt_date =
                                         ADD_MONTHS (
                                            TO_DATE (
                                               pul.Get_Mas_Ini_Val ('sFdat1'),
                                               'dd.mm.yyyy'),
                                            -1)
                                  AND (mm.ostq - mm.crdosq + mm.crkosq) <> 0) m
                    WHERE k.r020 = a.nbs AND k.kf = '1B' AND a.acc = m.acc
                          AND (m.ostq <> 0
                               AND a.nbs NOT IN
                                      ('1500',
                                       '1600',
                                       '1607',
                                       '1608',
                                       '2600',
                                       '2605',
                                       '2607',
                                       '2620',
                                       '2625',
                                       '2627',
                                       '2650',
                                       '2655',
                                       '2657')
                               OR m.ostq < 0
                                  AND a.nbs IN
                                         ('1500',
                                          '1600',
                                          '1607',
                                          '1608',
                                          '2600',
                                          '2605',
                                          '2607',
                                          '2620',
                                          '2625',
                                          '2627',
                                          '2650',
                                          '2655',
                                          '2657'))) q
            WHERE q.acc = r.acc(+) AND (q.OSTq + NVL (r.BVq, 0)) <> 0);

PROMPT *** Create  grants  GL_NBU23_REZ_ACC ***
grant SELECT                                                                 on GL_NBU23_REZ_ACC to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on GL_NBU23_REZ_ACC to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on GL_NBU23_REZ_ACC to START1;
grant SELECT                                                                 on GL_NBU23_REZ_ACC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/GL_NBU23_REZ_ACC.sql =========*** End *
PROMPT ===================================================================================== 
