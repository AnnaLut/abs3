

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_CORRNLS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_CORRNLS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW_CORRNLS ("KV", "LCV", "NLS", "BIC", "NAME", "ACC", "TRANSIT", "THEIR_ACC") AS 
  SELECT an.KV,
          tb.LCV,
          an.NLS,
          ba.BIC,
          sw.NAME,
          ba.ACC,
          ba.TRANSIT,
          ba.THEIR_ACC
        FROM accounts an
          INNER JOIN bic_acc ba ON ba.acc = an.acc
          INNER JOIN sw_banks sw ON sw.bic = ba.bic
          INNER JOIN tabval tb ON tb.kv = an.kv
          LEFT OUTER JOIN accounts at ON at.acc = ba.TRANSIT;

PROMPT *** Create  grants  V_SW_CORRNLS ***
grant SELECT                                                                 on V_SW_CORRNLS    to BARSREADER_ROLE;
grant FLASHBACK,INSERT,SELECT,UPDATE                                         on V_SW_CORRNLS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SW_CORRNLS    to START1;
grant SELECT                                                                 on V_SW_CORRNLS    to UPLD;
grant FLASHBACK,SELECT                                                       on V_SW_CORRNLS    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_CORRNLS.sql =========*** End *** =
PROMPT ===================================================================================== 
