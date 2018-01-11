

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORR_ACC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORR_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CORR_ACC ("KV", "LCV", "NLS", "BIC", "NAME", "ACC", "NLS3739", "TRANSIT_ACC", "THEIR_ACC") AS 
  SELECT an.KV,
          t.LCV,
          an.NLS,
          bic_acc.BIC,
          s.NAME,
          bic_acc.ACC,
          at.NLS nls3739,
          bic_acc.TRANSIT TRANSIT_ACC,
          bic_acc.THEIR_ACC
     FROM accounts an,
          accounts at,
          tabval t,
          bic_acc,
          sw_banks s
    WHERE     an.acc = bic_acc.acc
          AND an.kv = t.kv
          AND bic_acc.BIC = s.BIC
          AND at.acc(+) = bic_acc.TRANSIT;

PROMPT *** Create  grants  V_CORR_ACC ***
grant SELECT                                                                 on V_CORR_ACC      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CORR_ACC      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CORR_ACC      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORR_ACC.sql =========*** End *** ===
PROMPT ===================================================================================== 
