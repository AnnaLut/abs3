create or replace view V_MBM_DAY_TURNOVERS
as
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

grant select on V_MBM_DAY_TURNOVERS to BARS_ACCESS_DEFROLE;