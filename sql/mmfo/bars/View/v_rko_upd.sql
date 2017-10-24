

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RKO_UPD.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RKO_UPD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RKO_UPD ("BRANCH", "NLS0", "NMS", "NLS1", "NLS2", "ACC0", "ACC1", "ACC2", "RNK", "NLSD", "ACCD") AS 
  SELECT a0.BRANCH BRANCH,
          a0.nls nls0,
          a0.NMS NMS,
          a1.nls nls1,
          a2.nls nls2,
          r.acc  acc0,
          r.acc1,
          r.acc2,
          a0.RNK RNK,
          nvl(a3.nls,a0.nls) NLSD,
          r.accd ACCD
     FROM rko_lst   r,
          accounts a0,
          accounts a1,
          accounts a2,
          accounts a3
    WHERE r.acc = a0.acc AND r.acc1 = a1.acc(+) AND r.acc2 = a2.acc(+) AND r.accd = a3.acc(+);

PROMPT *** Create  grants  V_RKO_UPD ***
grant DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_RKO_UPD       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_RKO_UPD       to RKO;
grant DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_RKO_UPD       to START1;
grant FLASHBACK,SELECT                                                       on V_RKO_UPD       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RKO_UPD.sql =========*** End *** ====
PROMPT ===================================================================================== 
