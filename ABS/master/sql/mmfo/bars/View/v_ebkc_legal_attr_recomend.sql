

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EBKC_LEGAL_ATTR_RECOMEND.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EBKC_LEGAL_ATTR_RECOMEND ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_LEGAL_ATTR_RECOMEND ("ATTR_GR_ID", "ATTR_GR_NAME", "SORT_NUM", "KF", "RNK", "NAME", "VALUE", "DB_VALUE", "RECOMMENDVALUE", "DESCR", "ATT_UKR_NAME", "REQUIRED", "TYPE", "PAGE_ITEM_VIEW") AS 
  select
       eca.group_id as attr_gr_id,
       (select name from ebk_card_attr_groups where id = eca.group_id) as attr_gr_name,
       eca.sort_num,
       terua.kf,
       terua.rnk,
       terua.name,
       terua.value,
       ebkc_wforms_utl.get_db_value(terua.rnk, terua.name, 'L') as db_value,
       terua.recommendvalue,
       terua.descr,
       eca.descr as att_ukr_name,
       eca.required,
       eca.type,
       eca.page_item_view
      --,eca.list_of_values
from EBKC_REQ_UPDCARD_ATTR  terua,
     EBKC_CARD_ATTRIBUTES  eca
where terua.name = eca.name
  and terua.cust_type=eca.cust_type
  and terua.cust_type = 'L';

PROMPT *** Create  grants  V_EBKC_LEGAL_ATTR_RECOMEND ***
grant SELECT                                                                 on V_EBKC_LEGAL_ATTR_RECOMEND to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EBKC_LEGAL_ATTR_RECOMEND.sql ========
PROMPT ===================================================================================== 
