

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/AQ$_AQT_KLBX_REPLIES_F.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view AQ$_AQT_KLBX_REPLIES_F ***

  CREATE OR REPLACE FORCE VIEW BARS.AQ$_AQT_KLBX_REPLIES_F ("Q_NAME", "ROW_ID", "MSGID", "CORRID", "PRIORITY", "STATE", "DELAY", "EXPIRATION", "ENQ_TIME", "ENQ_UID", "ENQ_TID", "DEQ_TIME", "DEQ_UID", "DEQ_TID", "RETRY_COUNT", "EXCEPTION_QSCHEMA", "EXCEPTION_QUEUE", "CSCN", "DSCN", "CHAIN_NO", "LOCAL_ORDER_NO", "TIME_MANAGER_INFO", "STEP_NO", "USER_DATA", "SENDER_NAME", "SENDER_ADDRESS", "SENDER_PROTOCOL", "DEQUEUE_MSGID", "DELIVERY_MODE", "SEQUENCE_NUM", "MSG_NUM", "QUEUE_ID", "USER_PROP") AS 
  SELECT  /*+ NO_MERGE (qo) USE_NL(qt) */ qt.q_name Q_NAME, qt.rowid ROW_ID, qt.msgid MSGID, qt.corrid CORRID, qt.priority PRIORITY, qt.state STATE, cast(FROM_TZ(qt.delay, '02:00') at time zone sessiontimezone as timestamp) DELAY, qt.expiration EXPIRATION, cast(FROM_TZ(qt.enq_time, '02:00') at time zone sessiontimezone as timestamp) ENQ_TIME, qt.enq_uid ENQ_UID, qt.enq_tid ENQ_TID, cast(FROM_TZ(qt.deq_time, '02:00') at time zone sessiontimezone as timestamp) DEQ_TIME, qt.deq_uid DEQ_UID, qt.deq_tid DEQ_TID, qt.retry_count RETRY_COUNT, qt.exception_qschema EXCEPTION_QSCHEMA, qt.exception_queue EXCEPTION_QUEUE, qt.cscn CSCN, qt.dscn DSCN, qt.chain_no CHAIN_NO, qt.local_order_no LOCAL_ORDER_NO, cast(FROM_TZ(qt.time_manager_info, '02:00') at time zone sessiontimezone as timestamp)   TIME_MANAGER_INFO, qt.step_no STEP_NO, qt.user_data USER_DATA ,qt.sender_name SENDER_NAME, qt.sender_address SENDER_ADDRESS, qt.sender_protocol SENDER_PROTOCOL, qt.dequeue_msgid DEQUEUE_MSGID, 'PERSISTENT' DELIVERY_MODE, 0 SEQUENCE_NUM, 0 MSG_NUM, qo.qid QUEUE_ID, qt.user_prop USER_PROP FROM "AQT_KLBX_REPLIES" qt, SYS.ALL_INT_DEQUEUE_QUEUES qo  WHERE qt.q_name = qo.name AND qo.owner = 'BARS' WITH READ ONLY;

PROMPT *** Create  grants  AQ$_AQT_KLBX_REPLIES_F ***
grant SELECT                                                                 on AQ$_AQT_KLBX_REPLIES_F to BARSREADER_ROLE;
grant SELECT                                                                 on AQ$_AQT_KLBX_REPLIES_F to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/AQ$_AQT_KLBX_REPLIES_F.sql =========***
PROMPT ===================================================================================== 
