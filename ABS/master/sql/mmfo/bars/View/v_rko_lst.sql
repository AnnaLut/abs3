

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RKO_LST.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RKO_LST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RKO_LST ("ACC", "ACCD", "DAT0A", "DAT0B", "S0", "KOLDOK", "DAT1A", "DAT1B", "ACC1", "DAT2A", "DAT2B", "ACC2", "COMM", "KF", "BRANCH") AS 
  SELECT v."ACC",
          v."ACCD",
          v."DAT0A",
          v."DAT0B",
          v."S0",
          v."KOLDOK",
          v."DAT1A",
          v."DAT1B",
          v."ACC1",
          v."DAT2A",
          v."DAT2B",
          v."ACC2",
          v."COMM",
          v."KF",
          a.branch
     FROM RKO_LST v, Accounts a
    WHERE v.acc = a.acc;

PROMPT *** Create  grants  V_RKO_LST ***
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_RKO_LST       to BARS_ACCESS_DEFROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_RKO_LST       to RKO;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_RKO_LST       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RKO_LST.sql =========*** End *** ====
PROMPT ===================================================================================== 
