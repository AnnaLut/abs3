

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/AQ$BARS_MSG_QT_R.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view AQ$BARS_MSG_QT_R ***

  CREATE OR REPLACE FORCE VIEW BARS.AQ$BARS_MSG_QT_R ("QUEUE", "NAME", "ADDRESS", "PROTOCOL", "RULE", "RULE_SET", "TRANSFORMATION") AS 
  SELECT queue_name QUEUE, s.name NAME , address ADDRESS , protocol PROTOCOL, rule_condition RULE, ruleset_name RULE_SET, trans_name TRANSFORMATION  FROM "AQ$_BARS_MSG_QT_S" s , sys.all_rules r WHERE (bitand(s.subscriber_type, 1) = 1) AND s.rule_name = r.rule_name and r.rule_owner = 'BARS'  WITH READ ONLY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/AQ$BARS_MSG_QT_R.sql =========*** End *
PROMPT ===================================================================================== 
