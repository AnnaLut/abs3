

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_PAYMENTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_PAYMENTS ("PAYMENT_ID", "VALUE_DATE", "PAYER_ACCOUNT", "PAYER_IPN", "PAYMENT_AMOUNT", "FEE_AMOUNT", "DEBT_AMOUNT", "PAYMENT_CURRENCY", "PAYER_MFO", "RECEIVER_ACCOUNT", "RECEIVER_MFO", "RECEIVER_NAME", "RECEIVER_EDRPOU", "PURPOSE", "CUSTOMER_ACCOUNT", "PAYMENT_STATE_ID", "PAYMENT_STATE", "PRODUCT_ID", "PRODUCT_NAME", "ORDER_ID", "RNK") AS 
  select
       p.id as payment_id,
       p.value_date, -- Дата платежа
       a.nls payer_account,   -- Рахунок відправника
       c.okpo payer_ipn,      -- Ідентифікаційний код відправника
       p.payment_amount,      -- Сума переказу
       p.fee_amount,          -- Комісія за переказ
       p.debt_amount,        -- Борг
       a.kv payment_currency, -- Валюта переказу
       a.kf payer_mfo,        -- МФО банка відправника
       case when o.order_type_id = 1 then sep.receiver_account
            when o.order_type_id = 2 then sbonf.receiver_account
            when o.order_type_id = 3 then sp.receiver_account
            when o.order_type_id = 4 then sp.receiver_account
            else null
       end receiver_account, -- Рахунок отримувача
       case when o.order_type_id = 1 then sep.receiver_mfo
            when o.order_type_id = 2 then sbonf.receiver_mfo
            when o.order_type_id = 3 then sp.receiver_mfo
            when o.order_type_id = 4 then sp.receiver_mfo
            else null
       end receiver_mfo, -- МФО банку отримувача
       case when o.order_type_id = 1 then sep.receiver_name
            when o.order_type_id = 2 then sbonf.receiver_name
            when o.order_type_id = 3 then sp.receiver_name
            when o.order_type_id = 4 then sp.receiver_name
            else null
       end receiver_name, -- отримувач
       case when o.order_type_id = 1 then sep.receiver_edrpou
            when o.order_type_id = 2 then sbonf.receiver_edrpou
            when o.order_type_id = 3 then sp.receiver_edrpou
            when o.order_type_id = 4 then sp.receiver_edrpou
            else null
       end receiver_edrpou,-- Ідентифікаційний код отримувача
       case when p.purpose is null then
                 case when o.order_type_id = 1 then sep.purpose
                      when o.order_type_id = 2 then sbonf.purpose
                      when o.order_type_id = 3 then sp.payment_name
                      when o.order_type_id = 4 then sp.payment_name
                 end
            else p.purpose
       end purpose, -- Призначення платежу
       case
            when o.order_type_id = 3 then sbonc.customer_account
            when o.order_type_id = 4 then sbonnc.customer_account
            else null
       end customer_account, --Особовий Рахунок
      p.state as payment_state_id,
      sto_payment_utl.get_payment_state_name(p.state) payment_state, -- Статус (списано/не списано)
      nvl(prod.id,0) as product_id,
      prod.product_name,
      o.id as order_id,
      c.rnk
from   bars.sto_payment p
join   bars.sto_order o on o.id = p.order_id
join   bars.accounts a on a.acc = o.payer_account_id
join   bars.customer c on c.rnk = a.rnk
left join bars.sto_product prod on prod.id = o.product_id
left join bars.sto_sbon_product sp on sp.id = prod.id
left join bars.sto_sep_order sep on sep.id = o.id
left join bars.sto_sbon_order_free sbonf on sbonf.id = o.id
left join bars.sto_sbon_order_contr sbonc on sbonc.id = o.id
left join bars.sto_sbon_order_no_contr sbonnc on sbonnc.id = o.id
;

PROMPT *** Create  grants  V_STO_PAYMENTS ***
grant SELECT                                                                 on V_STO_PAYMENTS  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_PAYMENTS.sql =========*** End ***
PROMPT ===================================================================================== 
