
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_lookup_item.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_LOOKUP_ITEM force as object
(
       item_id number(38),
       item_code varchar2(4000 byte),
       item_name varchar2(4000 byte)
);
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_lookup_item.sql =========*** End *** 
 PROMPT ===================================================================================== 
 