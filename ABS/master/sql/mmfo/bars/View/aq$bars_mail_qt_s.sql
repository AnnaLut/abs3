

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/AQ$BARS_MAIL_QT_S.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view AQ$BARS_MAIL_QT_S ***

  CREATE OR REPLACE FORCE VIEW BARS.AQ$BARS_MAIL_QT_S ("QUEUE", "NAME", "ADDRESS", "PROTOCOL", "TRANSFORMATION", "QUEUE_TO_QUEUE") AS 
  SELECT queue_name QUEUE, name NAME , address ADDRESS , protocol PROTOCOL, trans_name TRANSFORMATION, decode(bitand(SUBSCRIBER_TYPE, 512), 512, 'TRUE', 'FALSE') QUEUE_TO_QUEUE  FROM "AQ$_BARS_MAIL_QT_S" s  WHERE (bitand(s.subscriber_type, 1) = 1)  WITH READ ONLY;

PROMPT *** Create  grants  AQ$BARS_MAIL_QT_S ***
grant SELECT                                                                 on AQ$BARS_MAIL_QT_S to BARSREADER_ROLE;
grant SELECT                                                                 on AQ$BARS_MAIL_QT_S to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AQ$BARS_MAIL_QT_S to START1;
grant SELECT                                                                 on AQ$BARS_MAIL_QT_S to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/AQ$BARS_MAIL_QT_S.sql =========*** End 
PROMPT ===================================================================================== 
