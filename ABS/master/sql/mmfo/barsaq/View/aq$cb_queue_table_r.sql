

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/AQ$CB_QUEUE_TABLE_R.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view AQ$CB_QUEUE_TABLE_R ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.AQ$CB_QUEUE_TABLE_R ("QUEUE", "NAME", "ADDRESS", "PROTOCOL", "RULE", "RULE_SET", "TRANSFORMATION") AS 
  SELECT queue_name QUEUE, s.name NAME , address ADDRESS , protocol PROTOCOL, rule_condition RULE, ruleset_name RULE_SET, trans_name TRANSFORMATION  FROM "AQ$_CB_QUEUE_TABLE_S" s , sys.all_rules r WHERE (bitand(s.subscriber_type, 1) = 1) AND s.rule_name = r.rule_name and r.rule_owner = 'BARSAQ'  WITH READ ONLY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/AQ$CB_QUEUE_TABLE_R.sql =========*** 
PROMPT ===================================================================================== 
