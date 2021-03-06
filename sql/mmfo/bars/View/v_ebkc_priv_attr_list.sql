

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EBKC_PRIV_ATTR_LIST.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EBKC_PRIV_ATTR_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_PRIV_ATTR_LIST ("ATTR_GR_ID", "ATTR_GR_NAME", "SORT_NUM", "KF", "RNK", "NAME", "DB_VALUE", "ENABLE_CHANGE", "ATT_UKR_NAME", "REQUIRED", "TYPE", "LIST_OF_VALUES", "PAGE_ITEM_VIEW") AS 
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

PROMPT *** Create  grants  V_EBKC_PRIV_ATTR_LIST ***
grant SELECT                                                                 on V_EBKC_PRIV_ATTR_LIST to BARSREADER_ROLE;
grant SELECT                                                                 on V_EBKC_PRIV_ATTR_LIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_EBKC_PRIV_ATTR_LIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EBKC_PRIV_ATTR_LIST.sql =========*** 
PROMPT ===================================================================================== 
