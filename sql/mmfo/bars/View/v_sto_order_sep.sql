

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_ORDER_SEP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_ORDER_SEP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_ORDER_SEP ("ID", "CUSTOMER_ID", "PAYER_ACCOUNT_ID", "START_DATE", "STOP_DATE", "HOLIDAY_SHIFT", "PAYMENT_FREQUENCY", "REGULAR_AMOUNT", "RECEIVER_MFO", "RECEIVER_ACCOUNT", "RECEIVER_NAME", "RECEIVER_EDRPOU", "PURPOSE") AS 
  select o.id,
       a.rnk customer_id,
       o.payer_account_id,
       o.start_date,
       o.stop_date,
       o.holiday_shift,
       o.payment_frequency,
       osep.regular_amount,
       osep.receiver_mfo,
       osep.receiver_account,
       osep.receiver_name,
       osep.receiver_edrpou,
       osep.purpose
from   sto_order o
join accounts a on a.acc = o.payer_account_id
join sto_sep_order osep on osep.id = o.id/*
where o.cancel_date is null and
      (o.stop_date is null or o.stop_date >= bankdate())*/;

PROMPT *** Create  grants  V_STO_ORDER_SEP ***
grant SELECT                                                                 on V_STO_ORDER_SEP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_ORDER_SEP.sql =========*** End **
PROMPT ===================================================================================== 
