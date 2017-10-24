

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SPOT.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SPOT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SPOT ("KV", "VDATE", "ACC", "OB22", "RATE_K", "RATE_P", "BRANCH", "OST") AS 
  SELECT s.kv, s.vdate, s.acc, i.ob22, s.rate_k, s.rate_p, s.branch,
          fost (s.acc, s.vdate) / 100
     FROM spot s, accounts i
    WHERE s.acc = i.acc ;

PROMPT *** Create  grants  V_SPOT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SPOT          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_SPOT          to PYOD001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SPOT          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_SPOT          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SPOT.sql =========*** End *** =======
PROMPT ===================================================================================== 
