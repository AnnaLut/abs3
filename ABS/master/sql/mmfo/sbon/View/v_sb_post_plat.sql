create or replace view v_sb_post_plat as
select p.id id_plat,
       case when p.state = 13 then 0
            else p.state
       end status,
       sprod.contract_id id_dog,
       prod.order_type_id - 2 work_mode,
       case when o.order_type_id = 3 then sbonc.customer_account
            when o.order_type_id = 4 then sbonnc.customer_account
            else null
       end client_contract,
       case when o.order_type_id = 2 then sbonf.receiver_account
            else sprod.receiver_account
       end rozrah,
       case when o.order_type_id = 2 then sbonf.receiver_name
            else sprod.receiver_name
       end nazva,
       case when o.order_type_id = 2 then sbonf.receiver_edrpou
            else sprod.receiver_edrpou
       end koorg,
       case when o.order_type_id = 2 then sbonf.receiver_mfo
            else sprod.receiver_mfo
       end mfo,
       p.debt_amount suma_borg,
       p.payment_amount sum_op,
       case when o.order_type_id = 3 then sbonc.ceiling_amount
            else null
       end suma_plat,
       p.fee_amount suma_kom,
       case when o.order_type_id = 2 then sbonf.purpose
            else p.purpose
       end purpose,
       bars.sto_payment_utl.get_payment_additional_info(o.payer_account_id, o.id) dodpar,
       p.value_date date_start,
       cast(null as date) date_oper
from   bars.sto_payment p
join   bars.sto_order o on o.id = p.order_id
join   bars.sto_product prod on prod.id = o.product_id
join   bars.sto_sbon_product sprod on sprod.id = prod.id
left join bars.sto_sbon_order_free sbonf on sbonf.id = o.id
left join bars.sto_sbon_order_contr sbonc on sbonc.id = o.id
left join bars.sto_sbon_order_no_contr sbonnc on sbonnc.id = o.id
where o.order_type_id in (2, 3, 4);
