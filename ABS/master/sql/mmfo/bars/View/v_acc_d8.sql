

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACC_D8.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACC_D8 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACC_D8 ("ACC", "NLS", "KV", "PAP", "NBS", "DAOS", "MDATE", "ISP", "TIP") AS 
  SELECT s.acc, s.nls, s.kv, s.pap, s.nbs, s.daos, s.mdate, s.isp, s.tip
    FROM accounts s
 ;

PROMPT *** Create  grants  V_ACC_D8 ***
grant SELECT                                                                 on V_ACC_D8        to BARSREADER_ROLE;
grant SELECT                                                                 on V_ACC_D8        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ACC_D8        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACC_D8.sql =========*** End *** =====
PROMPT ===================================================================================== 
