
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_attribute_values.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_ATTRIBUTE_VALUES force is table of t_attribute_value
/

 show err;
 
PROMPT *** Create  grants  T_ATTRIBUTE_VALUES ***
grant EXECUTE                                                                on T_ATTRIBUTE_VALUES to BARS_DM;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_attribute_values.sql =========*** End
 PROMPT ===================================================================================== 
 