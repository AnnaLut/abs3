

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_ORDER.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_ORDER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_ORDER ("ID", "CUSTOMER_ID", "CUSTOMER_NMK", "PAYER_ACCOUNT", "CURRENCY_ID", "ORDER_KIND_ID", "ORDER_KIND_NAME", "REGULAR_AMOUNT", "STOP_DATE", "RECEIVER", "PAYMENT_DETAILS", "PRIORITY", "USER_NAME", "ORD_STATE", "REG_ORD_DATE", "ORD_STATE_NAME", "BRANCH", "SMSSEND") AS 
  select 
          /*Changed 11.06.2015 */
          o.id,
          a.rnk customer_id,
          (select nmk from customer where rnk = a.rnk) as customer_nmk,
          a.nls payer_account,
          a.kv currency_id,
          o.order_type_id order_kind_id,
          k.type_name order_kind_name,
          case
             when o.order_type_id = 1 then osep.regular_amount
             when o.order_type_id = 2 then osbonf.regular_amount
             when o.order_type_id = 3 then osbonc.regular_amount
             when o.order_type_id = 4 then osbonnc.regular_amount
             else null
          end
             regular_amount,
          o.stop_date,
          case
             when o.order_type_id = 1
             then
                   osep.receiver_account
                || ' ('
                || osep.receiver_mfo
                || ')'
                || case
                      when osep.purpose is null then null
                      else ' - ' || osep.purpose
                   end
             when o.order_type_id = 2
             then
                   osbonf.receiver_account
                || ' ('
                || osbonf.receiver_mfo
                || ')'
                || case
                      when osep.purpose is null then null
                      else ' - ' || osbonf.purpose
                   end
             when o.order_type_id = 3
             then
                nvl (
                   (select    trim (p.receiver_name)
                           || ' (о/р: '
                           || osbonc.customer_account
                           || ')'
                           || case
                                 when p.payment_name is null then null
                                 else ' - ' || lower (trim (p.payment_name))
                              end
                      from sto_sbon_product p
                     where p.id = o.product_id),
                   osbonc.customer_account)
             when o.order_type_id = 4
             then
                nvl (
                   (select    trim (p.receiver_name)
                           || ' (о/р: '
                           || osbonnc.customer_account
                           || ')'
                           || case
                                 when p.payment_name is null then null
                                 else ' - ' || lower (trim (p.payment_name))
                              end
                      from sto_sbon_product p
                     where p.id = o.product_id),
                   osbonnc.customer_account)
             else
                null
          end
             receiver,
          case
             when o.order_type_id = 1 then osep.purpose
             when o.order_type_id = 2 then osbonf.purpose
             when o.order_type_id = 3 then null
             when o.order_type_id = 4 then null
             else null
          end
             payment_details,
          ROW_NUMBER ()
             OVER (PARTITION BY oa.payer_account_id  ORDER BY oa.priority)
             priority,
          /*(select ea.extra_attributes
           from   sto_order_extra_attributes ea
           where  ea.order_id = o.id) extra_attributes*/
          s.fio user_name,
          o.state as ord_state,
          greatest(trunc (o.registration_date), (select nvl(trunc(max(sys_time)),trunc (o.registration_date)) from sto_order_tracking where order_id = o.id and comment_text like 'Договір змінено.%')) as reg_ord_date,
          (select name from v_sto_order_state where id = o.state) as ord_state_name,
          o.branch,
          case when o.send_sms = 'Y' then 1 else 0 end as SmsSend
     from sto_order o
          join sto_type k on k.id = o.order_type_id
          join accounts a on a.acc = o.payer_account_id
          left join sto_sep_order osep on osep.id = o.id
          left join sto_sbon_order_free osbonf on osbonf.id = o.id
          left join sto_sbon_order_contr osbonc on osbonc.id = o.id
          left join sto_sbon_order_no_contr osbonnc on osbonnc.id = o.id
          left join staff$base s on s.id = o.user_id
          left join sto_order oa on oa.id = o.id and oa.state < 3    
--    WHERE     o.cancel_date IS NULL
--          AND (o.stop_date IS NULL OR o.stop_date >= bankdate ());

PROMPT *** Create  grants  V_STO_ORDER ***
grant SELECT                                                                 on V_STO_ORDER     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_ORDER.sql =========*** End *** ==
PROMPT ===================================================================================== 
