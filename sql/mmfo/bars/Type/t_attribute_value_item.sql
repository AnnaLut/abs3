
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_attribute_value_item.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_ATTRIBUTE_VALUE_ITEM force is object
(
       object_id number(38),
       valid_from date,
       valid_through date,
       user_id number(38),
       sys_time date,
       history_id number(38),
       number_value number(38, 12),
       string_value varchar2(4000 byte),
       date_value date,
       blob_value blob,
       clob_value clob,
       nest_id number(38)
)

/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_attribute_value_item.sql =========***
 PROMPT ===================================================================================== 
 