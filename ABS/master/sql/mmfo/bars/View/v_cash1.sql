

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CASH1.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CASH1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CASH1 ("KV", "NLS", "OB22", "BRANCH2", "BRANCH", "NOM_F", "NOM_B", "EQV_F", "BR2", "BR", "NMS") AS 
  SELECT a.kv, a.nls, a.ob22, SUBSTR (a.branch, 1, 15), a.branch,
          -a.ostc / 100, -a.ostb / 100,
          -gl.p_icurval (a.kv, a.ostc, gl.bd) / 100, b2.NAME, b.NAME, a.nms
     FROM accounts a,  branch b2, branch b
    WHERE a.nbs LIKE '100_'
      AND (a.ostb <> 0 OR a.ostc <> 0)
      AND b2.branch = SUBSTR (a.branch, 1, 15)
      AND b.branch = a.branch
   UNION ALL
   SELECT   a.kv, a.nbs, '**', SUBSTR (a.branch, 1, 15), 'По рiвню-2:',
            -SUM (a.ostc) / 100, -SUM (a.ostb) / 100,
            -SUM (gl.p_icurval (a.kv, a.ostc, gl.bd)) / 100, b2.NAME, '', ''
       FROM accounts a, branch b2
      WHERE a.nbs LIKE '100_'
        AND (a.ostb <> 0 OR a.ostc <> 0)
        AND b2.branch = SUBSTR (a.branch, 1, 15)
   GROUP BY a.kv, a.nbs, SUBSTR (a.branch, 1, 15), b2.NAME;

PROMPT *** Create  grants  V_CASH1 ***
grant SELECT                                                                 on V_CASH1         to BARSREADER_ROLE;
grant SELECT                                                                 on V_CASH1         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CASH1         to SALGL;
grant SELECT                                                                 on V_CASH1         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CASH1         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CASH1.sql =========*** End *** ======
PROMPT ===================================================================================== 
