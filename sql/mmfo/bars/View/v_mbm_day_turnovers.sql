

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBM_DAY_TURNOVERS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBM_DAY_TURNOVERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBM_DAY_TURNOVERS ("BANK_ID", "ACC_ID", "TRANSACTIONS_COUNT", "TURNOVER_DATE", "DEBIT", "DEBIT_EQUIVALENT", "CREDIT", "CREDIT_EQUIVALENT", "BALANCE_IN", "BALANCE_IN_EQUIVALENT", "BALANCE_OUT", "BALANCE_OUT_EQUIVALENT") AS 
  select
    s.KF as BANK_ID
    ,s.ACC as ACC_ID
    ,s.TRCN as TRANSACTIONS_COUNT
    ,s.FDAT as TURNOVER_DATE
    ,s.DOS as DEBIT
    ,s.DOSQ as DEBIT_EQUIVALENT
    ,s.KOS as CREDIT
    ,s.KOSQ as CREDIT_EQUIVALENT
    ,s.OSTF as BALANCE_IN
    ,s.OSTQ as BALANCE_IN_EQUIVALENT
    ,(s.OSTF+s.KOS-s.DOS) as BALANCE_OUT
    ,(s.OSTQ+s.KOSQ-s.DOSQ) as BALANCE_OUT_EQUIVALENT
from saldoa s;

PROMPT *** Create  grants  V_MBM_DAY_TURNOVERS ***
grant SELECT                                                                 on V_MBM_DAY_TURNOVERS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBM_DAY_TURNOVERS.sql =========*** En
PROMPT ===================================================================================== 
