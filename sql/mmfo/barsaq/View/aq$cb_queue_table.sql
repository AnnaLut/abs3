

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/AQ$CB_QUEUE_TABLE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view AQ$CB_QUEUE_TABLE ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.AQ$CB_QUEUE_TABLE ("QUEUE", "MSG_ID", "CORR_ID", "MSG_PRIORITY", "MSG_STATE", "DELAY", "DELAY_TIMESTAMP", "EXPIRATION", "ENQ_TIME", "ENQ_TIMESTAMP", "ENQ_USER_ID", "ENQ_TXN_ID", "ENQ_CSCN", "DEQ_TIME", "DEQ_TIMESTAMP", "DEQ_USER_ID", "DEQ_TXN_ID", "RETRY_COUNT", "EXCEPTION_QUEUE_OWNER", "EXCEPTION_QUEUE", "USER_DATA", "PROPAGATED_MSGID", "SENDER_NAME", "SENDER_ADDRESS", "SENDER_PROTOCOL", "ORIGINAL_MSGID", "ORIGINAL_QUEUE_NAME", "ORIGINAL_QUEUE_OWNER", "EXPIRATION_REASON", "CONSUMER_NAME", "ADDRESS", "PROTOCOL") AS 
  SELECT  q_name QUEUE, qt.msgid MSG_ID, corrid CORR_ID,  priority MSG_PRIORITY,  decode(s.subscriber_type,2,'UNDELIVERABLE',
                                             decode(h.dequeue_time, NULL,decode(l.dequeue_time, NULL, decode(state, 0,   'READY',	     
                              		                                          1,   'WAIT',	     
                                                                                  2,   'PROCESSED',	     
                                                                                  3,   'EXPIRED',
                                                                                  8,   'DEFERRED',
                                                                                 10,  'BUFFERED_EXPIRED'),(decode(l.transaction_id, NULL, 'UNDELIVERABLE', 'PROCESSED'))), (decode(h.transaction_id, NULL, 'UNDELIVERABLE', 'PROCESSED')))
                          )                         MSG_STATE,  cast(FROM_TZ(qt.delay, '00:00')
                 at time zone sessiontimezone as date) delay,  cast(FROM_TZ(qt.delay, '00:00')
                 at time zone sessiontimezone as timestamp) DELAY_TIMESTAMP, expiration,  cast(FROM_TZ(qt.enq_time, '00:00')
                 at time zone sessiontimezone as date) enq_time,  cast(FROM_TZ(qt.enq_time, '00:00')
                 at time zone sessiontimezone as timestamp)
                 enq_timestamp,   enq_uid ENQ_USER_ID,  qt.enq_tid ENQ_TXN_ID,  decode(qt.cscn, 0, c.cscn, qt.cscn) ENQ_CSCN,  decode(h.transaction_id, NULL, 
                 decode(l.transaction_id, NULL, TO_DATE(NULL), l.dequeue_time),
                        cast(FROM_TZ(h.dequeue_time, '00:00')
                 at time zone sessiontimezone as date)) DEQ_TIME,  decode(h.transaction_id, NULL, 
            decode(l.transaction_id, NULL, TO_TIMESTAMP(NULL), l.dequeue_time),
                        cast(FROM_TZ(h.dequeue_time, '00:00')
                 at time zone sessiontimezone as timestamp))
                 DEQ_TIMESTAMP,  decode(h.dequeue_user, NULL, l.dequeue_user, h.dequeue_user) 
	         DEQ_USER_ID,  decode(h.transaction_id, NULL, l.transaction_id, 
                 h.transaction_id) DEQ_TXN_ID,  h.retry_count retry_count,  decode (state, 0, exception_qschema, 
                                1, exception_qschema, 
                                2, exception_qschema,  
                                NULL) EXCEPTION_QUEUE_OWNER,  decode (state, 0, exception_queue, 
                                1, exception_queue, 
                                2, exception_queue,  
                                NULL) EXCEPTION_QUEUE,  user_data,  h.propagated_msgid PROPAGATED_MSGID,  sender_name  SENDER_NAME, sender_address  SENDER_ADDRESS, sender_protocol  SENDER_PROTOCOL, dequeue_msgid ORIGINAL_MSGID,  decode (h.dequeue_time, NULL, decode (l.dequeue_time, NULL,
                   decode (state, 3, exception_queue, NULL), 
                   decode (l.transaction_id, NULL, NULL, exception_queue)),
                   decode (h.transaction_id, NULL, NULL, exception_queue)) 
                                ORIGINAL_QUEUE_NAME,  decode (h.dequeue_time, NULL, decode (l.dequeue_time, NULL,
                   decode (state, 3, exception_qschema, NULL), 
                   decode (l.transaction_id, NULL, NULL, exception_qschema)),
                   decode (h.transaction_id, NULL, NULL, exception_qschema)) 
                                ORIGINAL_QUEUE_OWNER,  decode(s.subscriber_type,2,
                                         'Messages to be cleaned up later',
                        decode(h.dequeue_time, NULL, 
                               decode(state, 3, 
                                           decode(h.transaction_id, NULL, 
                                           decode (expiration , NULL , 
                                                   'MAX_RETRY_EXCEEDED',
                                                   'TIME_EXPIRATION'),
                                                   'INVALID_TRANSACTION', NULL,
                                                   'MAX_RETRY_EXCEEDED'), NULL),
                                           decode(h.transaction_id, NULL, 
                                                 'PROPAGATION_FAILURE', NULL)))
                 EXPIRATION_REASON,  decode(h.subscriber#, 0, decode(h.name, '0', NULL,
							        h.name),
					  s.name) CONSUMER_NAME,  s.address ADDRESS,  s.protocol PROTOCOL  FROM "CB_QUEUE_TABLE" qt LEFT OUTER JOIN "AQ$_CB_QUEUE_TABLE_C" c ON qt.enq_tid = c.enq_tid , "AQ$_CB_QUEUE_TABLE_H" h LEFT OUTER JOIN "AQ$_CB_QUEUE_TABLE_L" l  ON h.msgid = l.msgid AND h.subscriber# = l.subscriber# AND h.name = l.name AND h.address# = l.address#, "AQ$_CB_QUEUE_TABLE_S" s  WHERE  qt.msgid = h.msgid AND  ((h.subscriber# != 0 AND h.subscriber# = s.subscriber_id)  OR (h.subscriber# = 0 AND h.address# = s.subscriber_id)) AND (qt.state != 7 OR   qt.state != 9 )     UNION ALL SELECT q.name QUEUE, b.msgid MSG_ID, b.corrid CORR_ID, b.priority MSG_PRIORITY, decode (TO_CHAR(b.state), '4', 'IN MEMORY',
                           '5', 'DEFERRED',
                            '12', 'EXPIRED INMEMORY',
                                        NULL) MSG_STATE,  cast (null as DATE) DELAY,  cast (null as TIMESTAMP) DELAY_TIMESTAMP, b.expiration EXPIRATION, cast(FROM_TZ(b.enq_time, '00:00')
                   at time zone sessiontimezone as date) ENQ_TIME, cast(FROM_TZ(b.enq_time, '00:00')
                   at time zone sessiontimezone as timestamp)
                   ENQ_TIMESTAMP, b.enq_user_name ENQ_USER_ID, cast (null as VARCHAR2(30)) ENQ_TXN_ID,  null ENQ_CSCN, cast (null as DATE) DEQ_TIME, cast(null as TIMESTAMP) DEQ_TIMESTAMP,  cast (null as varchar2(30))  DEQ_USER_ID, cast(null as VARCHAR2(30)) DEQ_TXN_ID, b.retry_count RETRY_COUNT, b.exceptionq_schema EXCEPTION_QUEUE_OWNER, b.exceptionq_name EXCEPTION_QUEUE, sys.dbms_aq_bqview.get_opaque_payload(b.queue_id, b.msg_num, SYS.ANYDATA.ConvertNumber(0)) USER_DATA, cast(null as RAW(16)) PROPAGATED_MSGID, b.sender_name SENDER_NAME, b.sender_address SENDER_ADDRESS, b.sender_protocol SENDER_PROTOCOL, b.dequeue_msgid ORIGINAL_MSGID, cast (null as VARCHAR2(30)) ORIGINAL_QUEUE_NAME, cast(null as VARCHAR2(30)) ORIGINAL_QUEUE_OWNER, decode(b.state, 12, 'TIME_EXPIRATION', 
                          NULL) EXPIRATION_REASON,  s.name CONSUMER_NAME, s.address ADDRESS, s.protocol PROTOCOL FROM SYS.qt756831_BUFFER b, all_queues q, "AQ$_CB_QUEUE_TABLE_S" s WHERE s.subscriber_id = b.subscriber_id AND bitand(s.subscriber_type, 8) != 8 AND bitand(b.state, 4) = 4 AND q.qid = b.queue_id  UNION ALL SELECT p.q_name QUEUE, p.msgid MSG_ID, p.corrid CORR_ID, p.priority MSG_PRIORITY, decode (TO_CHAR(b.state), '2', 'SPILLED',
                           '3', 'DEFERRED SPILLED',
                           '10', 'EXPIRED SPILLED',
                                        NULL) MSG_STATE, cast(FROM_TZ(p.delay, '00:00')
                   at time zone sessiontimezone as date) DELAY,  cast(FROM_TZ(p.delay,  '00:00')
                  at time zone sessiontimezone as timestamp) DELAY_TIMESTAMP, p.expiration EXPIRATION, cast(FROM_TZ(p.enq_time, '00:00')
                   at time zone sessiontimezone as date) ENQ_TIME, cast(FROM_TZ(p.enq_time, '00:00')
                   at time zone sessiontimezone as timestamp)
                   ENQ_TIMESTAMP, p.enq_uid ENQ_USER_ID, p.enq_tid ENQ_TXN_ID,  null ENQ_CSCN, cast(FROM_TZ(p.deq_time, '00:00')
                   at time zone sessiontimezone as date) DEQ_TIME, cast(FROM_TZ(p.deq_time, '00:00')
                   at time zone sessiontimezone as timestamp)
                   DEQ_TIMESTAMP, p.deq_uid DEQ_USER_ID, p.deq_tid DEQ_TXN_ID, p.retry_count RETRY_COUNT, p.exception_qschema EXCEPTION_QUEUE_OWNER, p.exception_queue EXCEPTION_QUEUE, p.user_data USER_DATA, cast (null as RAW(16))PROPAGATED_MSGID,p.sender_name SENDER_NAME, p.sender_address SENDER_ADDRESS, p.sender_protocol SENDER_PROTOCOL, cast (null as RAW(16)) ORIGINAL_MSGID, cast (null as VARCHAR2(30)) ORIGINAL_QUEUE_NAME, cast (null as VARCHAR2(30)) ORIGINAL_QUEUE_OWNER, decode(b.state, 10, 'TIME_EXPIRATION', 
                          NULL) EXPIRATION_REASON, s.name CONSUMER_NAME, s.address ADDRESS, s.protocol PROTOCOL FROM "AQ$_CB_QUEUE_TABLE_P" p, SYS.qt756831_BUFFER b, "AQ$_CB_QUEUE_TABLE_S" s, all_queues q WHERE b.subscriber_id = s.subscriber_id AND bitand(s.subscriber_type, 8) != 8 AND bitand(b.state ,2) = 2 AND p.msgid = b.msgid AND q.qid = b.queue_id and p.q_name = q.name  WITH READ ONLY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/AQ$CB_QUEUE_TABLE.sql =========*** En
PROMPT ===================================================================================== 
