

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/GL_NBU23_REZ.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view GL_NBU23_REZ ***

  CREATE OR REPLACE FORCE VIEW BARS.GL_NBU23_REZ ("KV", "FDAT", "BBB", "OST", "BV", "DEL", "BRANCH") AS 
  SELECT NULL kv, TO_DATE (pul.Get_Mas_Ini_Val ('sFdat1'), 'dd.mm.yyyy') FDAT,
       q.BBB  , q.ostq / 100 OST,      NVL (r.BV, 0) BV, (q.ostq / 100 + NVL (r.BV, 0)) DEL,    q.BRANCH
FROM (SELECT branch,   SUBSTR (nbs, 1, 3) BBB,
             SUM ( gl.p_icurval (kv, BV,TO_DATE (pul.Get_Mas_Ini_Val ('sFdat1'), 'dd.mm.yyyy')))    BV
      FROM nbu23_rez
      where fdat = TO_DATE (pul.Get_Mas_Ini_Val ('sFdat1'), 'dd.mm.yyyy')
      GROUP BY branch, SUBSTR (nbs, 1, 3)
     ) r,
     (SELECT a.tobo BRANCH, SUBSTR (a.nbs, 1, 3) BBB, SUM (m.ostq-m.crdosq +m.crkosq)  OSTq
      FROM kl_f3_29 k, accounts a, ACCM_AGG_MONBALS m, accm_calendar c
      WHERE k.r020 = a.nbs
        AND (   m.ostq<>0 AND a.nbs NOT IN
                            ('1500','1600','1607','1608','2600','2605','2607','2620','2625','2627','2650','2655','2657')
             OR m.ostq< 0 AND a.nbs     IN
                            ('1500','1600','1607','1608','2600','2605','2607','2620','2625','2627','2650','2655','2657')
            )
        AND k.kf = '1B'   AND a.acc = m.acc   AND m.caldt_id = c.caldt_id
        AND c.caldt_date =ADD_MONTHS ( TO_DATE (pul.Get_Mas_Ini_Val ('sFdat1'), 'dd.mm.yyyy'),  -1)
      GROUP BY a.tobo, SUBSTR (a.nbs, 1, 3)
     ) q
WHERE q.BRANCH = r.branch(+) AND q.BBB = r.BBB(+) AND (q.ostq <> 0 OR NVL (r.BV, 0) <> 0);

PROMPT *** Create  grants  GL_NBU23_REZ ***
grant SELECT,UPDATE                                                          on GL_NBU23_REZ    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on GL_NBU23_REZ    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/GL_NBU23_REZ.sql =========*** End *** =
PROMPT ===================================================================================== 
