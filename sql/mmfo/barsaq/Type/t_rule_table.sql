
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/type/t_rule_table.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARSAQ.T_RULE_TABLE as object
  ( user_name   varchar2(100),
    table_name  varchar2(100),
    rule_name   varchar2(1000))
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/type/t_rule_table.sql =========*** End ***
 PROMPT ===================================================================================== 
 