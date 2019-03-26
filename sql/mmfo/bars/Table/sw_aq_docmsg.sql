

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_AQ_DOCMSG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_AQ_DOCMSG ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_AQ_DOCMSG ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_AQ_DOCMSG 
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
	USER_DATA BARS.T_SWDOCMSG , 
	USER_PROP SYS.ANYDATA 
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 OPAQUE TYPE USER_PROP STORE AS BASICFILE LOB (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_AQ_DOCMSG ***
 exec bpa.alter_policies('SW_AQ_DOCMSG');


COMMENT ON TABLE BARS.SW_AQ_DOCMSG IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.Q_NAME IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.MSGID IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.CORRID IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.PRIORITY IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.STATE IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.DELAY IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.EXPIRATION IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.TIME_MANAGER_INFO IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.LOCAL_ORDER_NO IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.CHAIN_NO IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.CSCN IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.DSCN IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.ENQ_TIME IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.ENQ_UID IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.ENQ_TID IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.DEQ_TIME IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.DEQ_UID IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.DEQ_TID IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.RETRY_COUNT IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.EXCEPTION_QSCHEMA IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.EXCEPTION_QUEUE IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.STEP_NO IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.RECIPIENT_KEY IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.DEQUEUE_MSGID IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.SENDER_NAME IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.SENDER_ADDRESS IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.SENDER_PROTOCOL IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.USER_DATA IS '';
COMMENT ON COLUMN BARS.SW_AQ_DOCMSG.USER_PROP IS '';




PROMPT *** Create  constraint SYS_C0011910 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_AQ_DOCMSG ADD PRIMARY KEY (MSGID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index AQ$_SW_AQ_DOCMSG_T ***
begin   
 execute immediate '
  CREATE INDEX BARS.AQ$_SW_AQ_DOCMSG_T ON BARS.SW_AQ_DOCMSG (TIME_MANAGER_INFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index AQ$_SW_AQ_DOCMSG_I ***
begin   
 execute immediate '
  CREATE INDEX BARS.AQ$_SW_AQ_DOCMSG_I ON BARS.SW_AQ_DOCMSG (Q_NAME, STATE, PRIORITY, ENQ_TIME, STEP_NO, CHAIN_NO, LOCAL_ORDER_NO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0011910 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0011910 ON BARS.SW_AQ_DOCMSG (MSGID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_AQ_DOCMSG ***
grant SELECT                                                                 on SW_AQ_DOCMSG    to BARSREADER_ROLE;
grant SELECT                                                                 on SW_AQ_DOCMSG    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_AQ_DOCMSG    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_AQ_DOCMSG.sql =========*** End *** 
PROMPT ===================================================================================== 