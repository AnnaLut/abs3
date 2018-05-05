create or replace force view EBK_CUST_ATTR_LIST_V
( ATTR_GR_ID
, ATTR_GR_NAME
, SORT_NUM
, KF
, RNK
, NAME
, DB_VALUE
, ENABLE_CHANGE
, ATT_UKR_NAME
, REQUIRED
, TYPE
, LIST_OF_VALUES
, PAGE_ITEM_VIEW
) AS
select eca.group_id as ATTR_GR_ID,
       (select name from ebk_card_attr_groups where id = eca.group_id) as ATTR_GR_NAME,
       eca.sort_num,
       c.kf,
       c.rnk,
       eca.name,
       EBK_WFORMS_UTL.GET_DB_VALUE(c.rnk, eca.name) as DB_VALUE,
       nvl((select 1
             from EBKC_REQ_UPDCARD_ATTR
            where KF        = c.kf
              and RNK       = c.rnk
              and NAME      = eca.name
              and CUST_TYPE = 'I' -- eca.CUST_TYPE
              and QUALITY  != 'C'
              and ROWNUM    = 1
            ),0) as ENABLE_CHANGE,
       eca.descr as att_ukr_name,
       eca.required,
       eca.type,
       eca.list_of_values,
       eca.page_item_view
  from CUSTOMER c
     , EBK_CARD_ATTRIBUTES eca -- EBKC_CARD_ATTRIBUTES eca
 where eca.GROUP_ID is not null
-- and eca.CUST_TYPE = 'I'
;

show errors;

grant SELECT on EBK_CUST_ATTR_LIST_V to BARS_ACCESS_DEFROLE;
grant SELECT on EBK_CUST_ATTR_LIST_V to BARSREADER_ROLE;
