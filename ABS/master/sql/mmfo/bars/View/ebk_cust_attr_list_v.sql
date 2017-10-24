

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/EBK_CUST_ATTR_LIST_V.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view EBK_CUST_ATTR_LIST_V ***

  CREATE OR REPLACE FORCE VIEW BARS.EBK_CUST_ATTR_LIST_V ("ATTR_GR_ID", "ATTR_GR_NAME", "SORT_NUM", "KF", "RNK", "NAME", "DB_VALUE", "ENABLE_CHANGE", "ATT_UKR_NAME", "REQUIRED", "TYPE", "LIST_OF_VALUES", "PAGE_ITEM_VIEW") AS 
  select
       eca.group_id as attr_gr_id,
       (select name from ebk_card_attr_groups where id = eca.group_id) as attr_gr_name ,
       eca.sort_num,
       kf_ss.kf,
       c.rnk,
       eca.name,
       ebk_wforms_utl.get_db_value(c.rnk, eca.name) as db_value,
       nvl((select 1 from tmp_ebk_req_updcard_attr
            where kf = kf_ss.kf
              and rnk= c.rnk
              and name =  eca.name
              and quality <> 'C'
              and rownum =1),0) as enable_change,
       --terua.value,
      -- terua.recommendvalue,
       --terua.descr,
       eca.descr as att_ukr_name,
       eca.required,
       eca.type,
       eca.list_of_values,
       eca.page_item_view
from  customer c,
      (select gl.kf as kf from dual) kf_ss,
 --  tmp_ebk_req_updcard_attr terua,
      ebk_card_attributes eca
where eca.group_id is not null;

PROMPT *** Create  grants  EBK_CUST_ATTR_LIST_V ***
grant SELECT                                                                 on EBK_CUST_ATTR_LIST_V to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/EBK_CUST_ATTR_LIST_V.sql =========*** E
PROMPT ===================================================================================== 
