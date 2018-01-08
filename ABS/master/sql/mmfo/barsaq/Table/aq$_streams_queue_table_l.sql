

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/AQ$_STREAMS_QUEUE_TABLE_L.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  table AQ$_STREAMS_QUEUE_TABLE_L ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.AQ$_STREAMS_QUEUE_TABLE_L 
   (	MSGID RAW(16), 
	SUBSCRIBER# NUMBER, 
	NAME VARCHAR2(30), 
	ADDRESS# NUMBER, 
	DEQUEUE_TIME TIMESTAMP (6) WITH TIME ZONE, 
	TRANSACTION_ID VARCHAR2(30), 
	DEQUEUE_USER VARCHAR2(30), 
	FLAGS RAW(1)
   ) USAGE QUEUE PCTFREE 0 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.AQ$_STREAMS_QUEUE_TABLE_L IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_L.MSGID IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_L.SUBSCRIBER# IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_L.NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_L.ADDRESS# IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_L.DEQUEUE_TIME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_L.TRANSACTION_ID IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_L.DEQUEUE_USER IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_L.FLAGS IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/AQ$_STREAMS_QUEUE_TABLE_L.sql ======
PROMPT ===================================================================================== 
