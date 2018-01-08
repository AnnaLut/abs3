

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MODULE_REQUEST_QT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MODULE_REQUEST_QT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MODULE_REQUEST_QT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MODULE_REQUEST_QT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''MODULE_REQUEST_QT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MODULE_REQUEST_QT ***
begin 
  execute immediate '
  CREATE TABLE BARS.MODULE_REQUEST_QT 
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
	ENQ_UID NUMBER, 
	ENQ_TID VARCHAR2(30), 
	DEQ_TIME TIMESTAMP (6), 
	DEQ_UID NUMBER, 
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
	USER_DATA SYS.AQ$_JMS_TEXT_MESSAGE , 
	USER_PROP SYS.ANYDATA 
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (USER_DATA.TEXT_LOB) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 OPAQUE TYPE USER_PROP STORE AS BASICFILE LOB (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MODULE_REQUEST_QT ***
 exec bpa.alter_policies('MODULE_REQUEST_QT');


COMMENT ON TABLE BARS.MODULE_REQUEST_QT IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.Q_NAME IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.MSGID IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.CORRID IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.PRIORITY IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.STATE IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.DELAY IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.EXPIRATION IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.TIME_MANAGER_INFO IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.LOCAL_ORDER_NO IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.CHAIN_NO IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.CSCN IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.DSCN IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.ENQ_TIME IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.ENQ_UID IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.ENQ_TID IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.DEQ_TIME IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.DEQ_UID IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.DEQ_TID IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.RETRY_COUNT IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.EXCEPTION_QSCHEMA IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.EXCEPTION_QUEUE IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.STEP_NO IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.RECIPIENT_KEY IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.DEQUEUE_MSGID IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.SENDER_NAME IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.SENDER_ADDRESS IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.SENDER_PROTOCOL IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.USER_DATA IS '';
COMMENT ON COLUMN BARS.MODULE_REQUEST_QT.USER_PROP IS '';




PROMPT *** Create  constraint SYS_C0010922 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MODULE_REQUEST_QT ADD PRIMARY KEY (MSGID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index AQ$_MODULE_REQUEST_QT_T ***
begin   
 execute immediate '
  CREATE INDEX BARS.AQ$_MODULE_REQUEST_QT_T ON BARS.MODULE_REQUEST_QT (TIME_MANAGER_INFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index AQ$_MODULE_REQUEST_QT_I ***
begin   
 execute immediate '
  CREATE INDEX BARS.AQ$_MODULE_REQUEST_QT_I ON BARS.MODULE_REQUEST_QT (Q_NAME, STATE, ENQ_TIME, STEP_NO, CHAIN_NO, LOCAL_ORDER_NO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0010922 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0010922 ON BARS.MODULE_REQUEST_QT (MSGID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MODULE_REQUEST_QT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MODULE_REQUEST_QT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MODULE_REQUEST_QT.sql =========*** End
PROMPT ===================================================================================== 
