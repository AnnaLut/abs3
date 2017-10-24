

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/AQ$AQ_REFSYNC_TBL_S.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view AQ$AQ_REFSYNC_TBL_S ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.AQ$AQ_REFSYNC_TBL_S ("QUEUE", "NAME", "ADDRESS", "PROTOCOL", "TRANSFORMATION", "QUEUE_TO_QUEUE") AS 
  SELECT queue_name QUEUE, name NAME , address ADDRESS , protocol PROTOCOL, trans_name TRANSFORMATION, decode(bitand(SUBSCRIBER_TYPE, 512), 512, 'TRUE', 'FALSE') QUEUE_TO_QUEUE  FROM "AQ$_AQ_REFSYNC_TBL_S" s  WHERE (bitand(s.subscriber_type, 1) = 1)  WITH READ ONLY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/AQ$AQ_REFSYNC_TBL_S.sql =========*** 
PROMPT ===================================================================================== 
