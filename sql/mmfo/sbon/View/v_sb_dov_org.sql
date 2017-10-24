create or replace view v_sb_dov_org as
select t.contract_id id_dog,
       t.contract_number nomdog,
       t.receiver_account rozrah,
       t.receiver_name nazva,
       t.transit_account tranzrah,
       t.receiver_edrpou kodorg,
       t.receiver_mfo mfo,
       t.payment_name nazva_plat,
       p.order_type_id - 2 work_mode,
       p.state status,
       cast(null as date) date_update,
       (select e.extra_attributes_metadata
        from   bars.sto_prod_extra_attributes e
        where  e.product_id = t.id) extra_attributes_metadata
from   bars.sto_product p
join   bars.sto_sbon_product t on t.id = p.id;
