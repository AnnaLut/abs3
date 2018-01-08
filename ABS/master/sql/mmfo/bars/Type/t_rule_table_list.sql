
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_rule_table_list.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_RULE_TABLE_LIST as table of t_rule_table
/

 show err;
 
PROMPT *** Create  grants  T_RULE_TABLE_LIST ***
grant EXECUTE                                                                on T_RULE_TABLE_LIST to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_rule_table_list.sql =========*** End 
 PROMPT ===================================================================================== 
 