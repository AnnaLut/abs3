

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BARS_MAIL_QT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BARS_MAIL_QT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BARS_MAIL_QT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BARS_MAIL_QT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BARS_MAIL_QT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BARS_MAIL_QT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BARS_MAIL_QT 
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
	USER_DATA BARS.T_BARS_MAIL , 
	USER_PROP SYS.ANYDATA 
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (USER_DATA.BODY) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING ) 
 OPAQUE TYPE USER_PROP STORE AS BASICFILE LOB (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BARS_MAIL_QT ***
 exec bpa.alter_policies('BARS_MAIL_QT');


COMMENT ON TABLE BARS.BARS_MAIL_QT IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.Q_NAME IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.MSGID IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.CORRID IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.PRIORITY IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.STATE IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.DELAY IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.EXPIRATION IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.TIME_MANAGER_INFO IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.LOCAL_ORDER_NO IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.CHAIN_NO IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.CSCN IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.DSCN IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.ENQ_TIME IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.ENQ_UID IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.ENQ_TID IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.DEQ_TIME IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.DEQ_UID IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.DEQ_TID IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.RETRY_COUNT IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.EXCEPTION_QSCHEMA IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.EXCEPTION_QUEUE IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.STEP_NO IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.RECIPIENT_KEY IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.DEQUEUE_MSGID IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.SENDER_NAME IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.SENDER_ADDRESS IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.SENDER_PROTOCOL IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.USER_DATA IS '';
COMMENT ON COLUMN BARS.BARS_MAIL_QT.USER_PROP IS '';




PROMPT *** Create  constraint SYS_C0010581 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARS_MAIL_QT ADD PRIMARY KEY (MSGID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0010581 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0010581 ON BARS.BARS_MAIL_QT (MSGID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BARS_MAIL_QT ***
grant SELECT                                                                 on BARS_MAIL_QT    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BARS_MAIL_QT    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BARS_MAIL_QT    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BARS_MAIL_QT    to START1;
grant SELECT                                                                 on BARS_MAIL_QT    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BARS_MAIL_QT.sql =========*** End *** 
PROMPT ===================================================================================== 
