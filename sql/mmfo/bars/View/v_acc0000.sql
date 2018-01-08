

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACC0000.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACC0000 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACC0000 ("BRANCH", "DAT", "OTM") AS 
  SELECT b.branch, d.dat,
          NVL ((SELECT 1
                  FROM saldoa s, accounts a
                 WHERE a.acc = s.acc
                   AND a.nls LIKE '0000%'
                   AND a.nbs IS NULL
                   AND a.branch = b.branch
                   AND s.fdat = d.dat
                   AND ROWNUM = 1),
               0
              ) otm
     FROM (SELECT branch
             FROM branch
            WHERE LENGTH (branch) = 22) b,
          (SELECT g.dat1 + (c.num - 1) dat
             FROM conductor c,
                  (SELECT NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                        'dd.mm.yyyy'
                                       ),
                               gl.bd
                              ) dat1,
                          NVL (TO_DATE (pul.get_mas_ini_val ('sFdat2'),
                                        'dd.mm.yyyy'
                                       ),
                               gl.bd
                              ) dat2
                     FROM DUAL) g
            WHERE g.dat1 + (c.num - 1) <= g.dat2) d;

PROMPT *** Create  grants  V_ACC0000 ***
grant SELECT                                                                 on V_ACC0000       to BARSREADER_ROLE;
grant SELECT                                                                 on V_ACC0000       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACC0000       to SALGL;
grant SELECT                                                                 on V_ACC0000       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACC0000.sql =========*** End *** ====
PROMPT ===================================================================================== 
