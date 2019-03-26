

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_ORDER_SBON_CONTR.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_ORDER_SBON_CONTR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_ORDER_SBON_CONTR ("ID", "CUSTOMER_ID", "PAYER_ACCOUNT_ID", "START_DATE", "STOP_DATE", "HOLIDAY_SHIFT", "PAYMENT_FREQUENCY", "PROVIDER_ID", "REGULAR_AMOUNT", "CEILING_AMOUNT", "CUSTOMER_ACCOUNT", "SENDSMS") AS 
  select o.id,
       a.rnk customer_id,
       o.payer_account_id,
       o.start_date,
       o.stop_date,
       o.holiday_shift,
       o.payment_frequency,
       o.product_id provider_id,
       osbonc.regular_amount,
       osbonc.ceiling_amount,
       osbonc.customer_account,
       o.SEND_SMS as sendsms
from   sto_order o
join accounts a on a.acc = o.payer_account_id
join sto_sbon_order_contr osbonc on osbonc.id = o.id/*
where o.cancel_date is null and
      (o.stop_date is null or o.stop_date >= bankdate())*/;

PROMPT *** Create  grants  V_STO_ORDER_SBON_CONTR ***
grant SELECT                                                                 on V_STO_ORDER_SBON_CONTR to BARSREADER_ROLE;
grant SELECT                                                                 on V_STO_ORDER_SBON_CONTR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STO_ORDER_SBON_CONTR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_ORDER_SBON_CONTR.sql =========***
PROMPT ===================================================================================== 