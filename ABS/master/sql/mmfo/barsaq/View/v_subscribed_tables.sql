

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_SUBSCRIBED_TABLES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SUBSCRIBED_TABLES ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_SUBSCRIBED_TABLES ("USER_NAME", "TABLE_NAME", "RULE_NAME") AS 
  select t.user_name, t.table_name, t.rule_name
from table (barsaq.bars_refsync.refsync_rule_tables) t
 ;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_SUBSCRIBED_TABLES.sql =========*** 
PROMPT ===================================================================================== 
