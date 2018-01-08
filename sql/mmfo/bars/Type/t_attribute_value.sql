
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_attribute_value.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_ATTRIBUTE_VALUE force as object
(
    attribute_id number(5),
    object_id number(38),
    number_value number(38, 12),
    string_value varchar2(4000 byte),
    date_value date,
    blob_value blob,
    clob_value clob,
    number_values number_list,
    string_values string_list,
    date_values date_list,
    blob_values blob_list,
    clob_values clob_list
)
not final
/

 show err;
 
PROMPT *** Create  grants  T_ATTRIBUTE_VALUE ***
grant EXECUTE                                                                on T_ATTRIBUTE_VALUE to BARS_DM;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_attribute_value.sql =========*** End 
 PROMPT ===================================================================================== 
 