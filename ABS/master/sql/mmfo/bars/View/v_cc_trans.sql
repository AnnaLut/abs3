

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_TRANS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_TRANS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_TRANS ("NPP", "REF", "ACC", "NLS", "KV", "FDAT", "SV", "SZ", "D_PLAN", "D_FAKT", "DAPP", "REFP", "COMM", "OSTC") AS 
  SELECT t.NPP,
          t.REF,
          t.ACC,
          a.NLS,
          a.KV,
          t.FDAT,
          t.SV,
          t.SZ,
          t.D_PLAN,
          t.D_FAKT,
          t.DAPP,
          t.REFP,
          t.COMM,
          t.sv - t.sz ostc
     FROM cc_trans t, accounts a
WHERE t.acc = a.acc;

PROMPT *** Create  grants  V_CC_TRANS ***
grant SELECT                                                                 on V_CC_TRANS      to BARSREADER_ROLE;
grant FLASHBACK,SELECT,UPDATE                                                on V_CC_TRANS      to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_CC_TRANS      to RCC_DEAL;
grant SELECT                                                                 on V_CC_TRANS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_TRANS.sql =========*** End *** ===
PROMPT ===================================================================================== 
