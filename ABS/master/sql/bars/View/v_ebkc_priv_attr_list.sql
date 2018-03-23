prompt =====================================
prompt create view v_ebkc_priv_attr_list
prompt =====================================

create or replace view V_EBKC_PRIV_ATTR_LIST
as
   select eca.group_id as attr_gr_id,
          ( select name 
              from ebk_card_attr_groups
             where id = eca.group_id
          ) as attr_gr_name,
          eca.sort_num,
          c.kf,
          c.rnk,
          eca.name,
          ebkc_wforms_utl.get_db_value (c.rnk, eca.name, eca.cust_type) as db_value,
          nvl( ( select 1 
                   from EBKC_REQ_UPDCARD_ATTR
                  where kf   = c.kf 
                    and rnk  = c.rnk 
                    and name = eca.name
                    and quality <> 'C'
                    and rownum=1 )
             , 0 ) as ENABLE_CHANGE,
          eca.descr as att_ukr_name,
          eca.required,
          eca.type,
          eca.list_of_values,
          eca.page_item_view             
     from customer c,
          ebkc_card_attributes eca
    where eca.group_id is not null
      and eca.cust_type = 'P'; 
      
prompt ======================================
prompt Give grants on v_ebkc_priv_attr_list
prompt ======================================

grant select on v_ebkc_priv_attr_list to bars_access_defrole;
