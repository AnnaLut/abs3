
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/r_cust_subgrp_ebk.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.R_CUST_SUBGRP_EBK as object (
 rnk               number(38),
 group_id          number(1) ,
 id_prc_quality    number,
 okpo              varchar2 (14 byte),
 nmk               varchar2 (70 byte),
 quality           number (6,2),
 document          varchar2 (31 byte),
 birth_day         varchar2 (10 byte),
 attr_qty          number,
 last_card_upd     date,
 last_user_upd     varchar2 (60 byte),
 branch            varchar2 (30)
);
/

 show err;
 
PROMPT *** Create  grants  R_CUST_SUBGRP_EBK ***
grant EXECUTE                                                                on R_CUST_SUBGRP_EBK to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/r_cust_subgrp_ebk.sql =========*** End 
 PROMPT ===================================================================================== 
 