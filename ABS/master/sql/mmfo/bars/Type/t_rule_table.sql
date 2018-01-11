
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_rule_table.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_RULE_TABLE as object
  ( user_name   varchar2(100),
    table_name  varchar2(100),
    rule_name   varchar2(1000))
/

 show err;
 
PROMPT *** Create  grants  T_RULE_TABLE ***
grant EXECUTE                                                                on T_RULE_TABLE    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_rule_table.sql =========*** End *** =
 PROMPT ===================================================================================== 
 