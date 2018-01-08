

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/EBK_CUST_ATTR_RECOMEND_V.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view EBK_CUST_ATTR_RECOMEND_V ***

  CREATE OR REPLACE FORCE VIEW BARS.EBK_CUST_ATTR_RECOMEND_V ("ATTR_GR_ID", "ATTR_GR_NAME", "SORT_NUM", "KF", "RNK", "NAME", "VALUE", "DB_VALUE", "RECOMMENDVALUE", "DESCR", "ATT_UKR_NAME", "REQUIRED", "TYPE", "PAGE_ITEM_VIEW") AS 
  select
       eca.group_id as attr_gr_id,
       (select name from ebk_card_attr_groups where id = eca.group_id) as attr_gr_name,
       eca.sort_num,
       terua.kf,
       terua.rnk,
       terua.name,
       terua.value,
       ebk_wforms_utl.get_db_value(terua.rnk, terua.name) as db_value,
       terua.recommendvalue,
       terua.descr,
       eca.descr as att_ukr_name,
       eca.required
      ,eca.type ,
       eca.page_item_view
      --,eca.list_of_values
from tmp_ebk_req_updcard_attr terua,
     ebk_card_attributes eca
where terua.name = eca.name;

PROMPT *** Create  grants  EBK_CUST_ATTR_RECOMEND_V ***
grant SELECT                                                                 on EBK_CUST_ATTR_RECOMEND_V to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/EBK_CUST_ATTR_RECOMEND_V.sql =========*
PROMPT ===================================================================================== 
