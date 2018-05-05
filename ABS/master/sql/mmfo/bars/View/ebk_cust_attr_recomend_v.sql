create or replace force view EBK_CUST_ATTR_RECOMEND_V
( ATTR_GR_ID
, ATTR_GR_NAME
, SORT_NUM
, KF
, RNK
, NAME
, VALUE
, DB_VALUE
, RECOMMENDVALUE
, DESCR
, ATT_UKR_NAME
, REQUIRED
, TYPE
, PAGE_ITEM_VIEW
) AS
select eca.group_id as attr_gr_id,
       (select name from ebk_card_attr_groups where id = eca.group_id) as attr_gr_name,
       eca.sort_num,
       era.kf,
       era.rnk,
       era.name,
       era.value,
       EBK_WFORMS_UTL.GET_DB_VALUE( era.RNK, era.NAME ) as db_value,
       era.recommendvalue,
       era.descr,
       eca.descr as att_ukr_name,
       eca.required
     , eca.type
     , eca.page_item_view
--   , eca.list_of_values
  from EBKC_REQ_UPDCARD_ATTR era
  join EBK_CARD_ATTRIBUTES   eca -- EBKC_CARD_ATTRIBUTES eca
    on ( era.NAME = eca.NAME )   -- and era.CUST_TYPE = eca.CUST_TYPE )
 where era.CUST_TYPE = 'I';

show errors;

grant SELECT on EBK_CUST_ATTR_RECOMEND_V to BARS_ACCESS_DEFROLE;
grant SELECT on EBK_CUST_ATTR_RECOMEND_V to BARSREADER_ROLE;
