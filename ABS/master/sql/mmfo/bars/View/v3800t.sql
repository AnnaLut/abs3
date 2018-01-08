

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V3800T.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V3800T ***

  CREATE OR REPLACE FORCE VIEW BARS.V3800T ("KV", "BRANCH", "ACC_3800", "NLS_3800", "OB22_3800", "NMS_3800", "N0_3800", "Q0_3800", "N1_3800", "Q1_3800", "ACC_3801", "NLS_3801", "OB22_3801", "NMS_3801", "N0_3801", "N1_3801", "DEL0", "DEL1") AS 
  select KV, BRANCH,
 ACC_3800, NLS_3800, OB22_3800, NMS_3800, N0_3800, Q0_3800, N1_3800, Q1_3800,
 ACC_3801, NLS_3801, OB22_3801, NMS_3801, N0_3801,          N1_3801,
     DEL0, DEL1
from
(SELECT a.KV,   a.BRANCH,
        a.acc   ACC_3800, a.nls   NLS_3800, a.ob22  OB22_3800,
        a.nms   NMS_3800, a.ostc0  N0_3800, a.ostq0   Q0_3800,
        a.ostc1  N1_3800, a.ostq1  Q1_3800,
        b.acc   ACC_3801, b.nls   NLS_3801, b.ob22  OB22_3801,
        b.nms   NMS_3801, b.ostc0  N0_3801, b.ostc1   N1_3801,
        a.ostq0 + b.ostc0 DEL0,
        a.ostq1 + b.ostc1 DEL1
 FROM vp_list v,
     (SELECT acc, kv, branch, nls, nms, ob22, ostc ostc0,
             gl.p_icurval (kv, ostc, gl.bd) ostq0, fost (acc, gl.bd - 1) ostc1,
             gl.p_icurval (kv, fost (acc, gl.bd - 1), gl.bd - 1) ostq1
      FROM accounts
      WHERE nbs = '3800' AND dazs IS NULL) a,
     (SELECT acc, nls, nms, ob22, ostc ostc0, fost (acc, gl.bd - 1) ostc1
      FROM accounts  WHERE nbs = '3801' AND dazs IS NULL) b
 WHERE a.acc = v.acc3800 AND b.acc = v.acc3801
UNION ALL
 SELECT a.kv, a.branch, a.acc, a.nls, a.ob22, a.nms, a.ostc0, a.ostq0,
        a.ostc1, a.ostq1, NULL, NULL, NULL, NULL, NULL, NULL, a.ostq0 del0,
        a.ostq1 del1
 FROM (SELECT acc, kv, branch, nls, nms, ob22, ostc ostc0,
              gl.p_icurval (kv, ostc, gl.bd) ostq0, fost (acc, gl.bd - 1) ostc1,
              gl.p_icurval (kv, fost (acc, gl.bd - 1), gl.bd - 1) ostq1
       FROM accounts  WHERE nbs = '3800' AND dazs IS NULL
        AND NOT EXISTS (SELECT 1 FROM vp_list WHERE acc3800=accounts.acc)) a
UNION ALL
 SELECT NULL, b.branch, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        b.acc, b.nls, b.ob22, b.nms, b.ostc0, b.ostc1, b.ostc0 del0, b.ostc1 del1
 FROM (SELECT acc, nls, nms, branch, ostc ostc0, ob22,
                  fost (acc, gl.bd - 1) ostc1
       FROM accounts WHERE nbs = '3801'  AND dazs IS NULL
        AND NOT EXISTS (SELECT 1 FROM vp_list WHERE acc3801=accounts.acc)) b
)
where
 ( nvl(N0_3800,1) <> 0 or nvl(Q0_3800,1) <> 0 or nvl(N1_3800,1) <> 0 or
   nvl(Q1_3800,1) <> 0 or nvl(N0_3801,1) <> 0 or nvl(N1_3801,1) <> 0    )
 ;

PROMPT *** Create  grants  V3800T ***
grant SELECT                                                                 on V3800T          to BARSREADER_ROLE;
grant SELECT                                                                 on V3800T          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V3800T          to SALGL;
grant SELECT                                                                 on V3800T          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V3800T.sql =========*** End *** =======
PROMPT ===================================================================================== 
