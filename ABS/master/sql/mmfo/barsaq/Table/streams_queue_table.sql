

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/STREAMS_QUEUE_TABLE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  table STREAMS_QUEUE_TABLE ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.STREAMS_QUEUE_TABLE 
   (	Q_NAME VARCHAR2(30), 
	MSGID RAW(16), 
	CORRID VARCHAR2(128), 
	PRIORITY NUMBER, 
	STATE NUMBER, 
	DELAY TIMESTAMP (6), 
	EXPIRATION NUMBER, 
	TIME_MANAGER_INFO TIMESTAMP (6), 
	LOCAL_ORDER_NO NUMBER, 
	CHAIN_NO NUMBER, 
	CSCN NUMBER, 
	DSCN NUMBER, 
	ENQ_TIME TIMESTAMP (6), 
	ENQ_UID VARCHAR2(30), 
	ENQ_TID VARCHAR2(30), 
	DEQ_TIME TIMESTAMP (6), 
	DEQ_UID VARCHAR2(30), 
	DEQ_TID VARCHAR2(30), 
	RETRY_COUNT NUMBER, 
	EXCEPTION_QSCHEMA VARCHAR2(30), 
	EXCEPTION_QUEUE VARCHAR2(30), 
	STEP_NO NUMBER, 
	RECIPIENT_KEY NUMBER, 
	DEQUEUE_MSGID RAW(16), 
	SENDER_NAME VARCHAR2(30), 
	SENDER_ADDRESS VARCHAR2(1024), 
	SENDER_PROTOCOL NUMBER, 
	USER_DATA SYS.ANYDATA , 
	USER_PROP SYS.ANYDATA 
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS 
 OPAQUE TYPE USER_DATA STORE AS BASICFILE LOB (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE ) 
 OPAQUE TYPE USER_PROP STORE AS BASICFILE LOB (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.STREAMS_QUEUE_TABLE IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.Q_NAME IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.MSGID IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.CORRID IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.PRIORITY IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.STATE IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.DELAY IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.EXPIRATION IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.TIME_MANAGER_INFO IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.LOCAL_ORDER_NO IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.CHAIN_NO IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.CSCN IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.DSCN IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.ENQ_TIME IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.ENQ_UID IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.ENQ_TID IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.DEQ_TIME IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.DEQ_UID IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.DEQ_TID IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.RETRY_COUNT IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.EXCEPTION_QSCHEMA IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.EXCEPTION_QUEUE IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.STEP_NO IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.RECIPIENT_KEY IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.DEQUEUE_MSGID IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.SENDER_NAME IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.SENDER_ADDRESS IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.SENDER_PROTOCOL IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.USER_DATA IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_QUEUE_TABLE.USER_PROP IS '';




PROMPT *** Create  constraint SYS_C0010588 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_QUEUE_TABLE ADD PRIMARY KEY (MSGID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0010588 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.SYS_C0010588 ON BARSAQ.STREAMS_QUEUE_TABLE (MSGID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/STREAMS_QUEUE_TABLE.sql =========***
PROMPT ===================================================================================== 
