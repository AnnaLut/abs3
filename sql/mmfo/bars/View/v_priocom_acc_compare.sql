

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_ACC_COMPARE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PRIOCOM_ACC_COMPARE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PRIOCOM_ACC_COMPARE ("ACC", "CURRENCY", "BALANCE") AS 
  select
    a.nls   as acc,
    a.kv    as currency,
    abs(a.ostc)  as balance
from accounts a;

PROMPT *** Create  grants  V_PRIOCOM_ACC_COMPARE ***
grant SELECT                                                                 on V_PRIOCOM_ACC_COMPARE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PRIOCOM_ACC_COMPARE to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_ACC_COMPARE.sql =========*** 
PROMPT ===================================================================================== 
