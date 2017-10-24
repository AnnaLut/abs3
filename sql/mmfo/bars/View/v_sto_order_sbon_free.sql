

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_ORDER_SBON_FREE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_ORDER_SBON_FREE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_ORDER_SBON_FREE ("ID", "CUSTOMER_ID", "PAYER_ACCOUNT_ID", "START_DATE", "STOP_DATE", "HOLIDAY_SHIFT", "PAYMENT_FREQUENCY", "PROVIDER_ID", "REGULAR_AMOUNT", "RECEIVER_MFO", "RECEIVER_ACCOUNT", "RECEIVER_NAME", "RECEIVER_EDRPOU", "PURPOSE", "SENDSMS") AS 
  select o.id,
       a.rnk customer_id,
       o.payer_account_id,
       o.start_date,
       o.stop_date,
       o.holiday_shift,
       o.payment_frequency,
       o.product_id provider_id,
       osbonf.regular_amount,
       osbonf.receiver_mfo,
       osbonf.receiver_account,
       osbonf.receiver_name,
       osbonf.receiver_edrpou,
       osbonf.purpose,
       o.SEND_SMS as sendsms
from   sto_order o
join accounts a on a.acc = o.payer_account_id
join sto_sbon_order_free osbonf on osbonf.id = o.id/*
where o.cancel_date is null and
      (o.stop_date is null or o.stop_date >= bankdate())*/;

PROMPT *** Create  grants  V_STO_ORDER_SBON_FREE ***
grant SELECT                                                                 on V_STO_ORDER_SBON_FREE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_ORDER_SBON_FREE.sql =========*** 
PROMPT ===================================================================================== 
