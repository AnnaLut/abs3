

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/EBK_DUP_CUST_ATTR_LIST_V.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view EBK_DUP_CUST_ATTR_LIST_V ***

  CREATE OR REPLACE FORCE VIEW BARS.EBK_DUP_CUST_ATTR_LIST_V ("ATTR_GR_ID", "ATTR_GR_NAME", "SORT_NUM", "KF", "RNK", "NAME", "DB_VALUE", "ATT_UKR_NAME", "REQUIRED", "TYPE") AS 
  select eca.group_id as attr_gr_id,
          (select name from ebk_card_attr_groups
            where id = eca.group_id) as attr_gr_name,
          eca.sort_num,
          kf_ss.kf,
          c.rnk,
          eca.name,
          ebk_dup_wform_utl.get_db_value (c.rnk, eca.name, eca.type) as db_value,
          eca.descr as att_ukr_name,
          eca.required,
          eca.type
     from customer c,
          (select gl.kf as kf from dual) kf_ss,
          ebk_card_attributes eca
    where eca.group_id is not null;

PROMPT *** Create  grants  EBK_DUP_CUST_ATTR_LIST_V ***
grant SELECT                                                                 on EBK_DUP_CUST_ATTR_LIST_V to BARSREADER_ROLE;
grant SELECT                                                                 on EBK_DUP_CUST_ATTR_LIST_V to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBK_DUP_CUST_ATTR_LIST_V to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/EBK_DUP_CUST_ATTR_LIST_V.sql =========*
PROMPT ===================================================================================== 
