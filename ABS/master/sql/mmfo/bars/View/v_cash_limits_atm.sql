

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CASH_LIMITS_ATM.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CASH_LIMITS_ATM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CASH_LIMITS_ATM ("ACC", "BRANCH", "CURRENCY", "ATM_NAME", "LIM_ACC", "LIM_DATE", "LIM_CURRENT", "LIM_MAX") AS 
  select a.ACC, a.BRANCH, a.KV, a.NMS, l.ACC, l.LIM_DATE, l.LIM_CURRENT, l.LIM_MAX
    from ACCOUNTS a
    left join CASH_LIMITS_ATM l on ( l.acc = a.acc )
   where a.NBS = '1004'
     and a.dazs is Null;

PROMPT *** Create  grants  V_CASH_LIMITS_ATM ***
grant SELECT                                                                 on V_CASH_LIMITS_ATM to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on V_CASH_LIMITS_ATM to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT,UPDATE                                                   on V_CASH_LIMITS_ATM to RPBN001;
grant SELECT                                                                 on V_CASH_LIMITS_ATM to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CASH_LIMITS_ATM.sql =========*** End 
PROMPT ===================================================================================== 
