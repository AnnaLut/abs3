

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/AQ$_TR_QT_S.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table AQ$_TR_QT_S ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.AQ$_TR_QT_S 
   (	SUBSCRIBER_ID NUMBER, 
	QUEUE_NAME VARCHAR2(30), 
	NAME VARCHAR2(30), 
	ADDRESS VARCHAR2(1024), 
	PROTOCOL NUMBER, 
	SUBSCRIBER_TYPE NUMBER, 
	RULE_NAME VARCHAR2(30), 
	TRANS_NAME VARCHAR2(65), 
	RULESET_NAME VARCHAR2(65), 
	NEGATIVE_RULESET_NAME VARCHAR2(65), 
	CSCN_LWM NUMBER, 
	CREATION_TIME TIMESTAMP (6) WITH TIME ZONE, 
	MODIFICATION_TIME TIMESTAMP (6) WITH TIME ZONE, 
	DELETION_TIME TIMESTAMP (6) WITH TIME ZONE, 
	SCN_AT_REMOVE NUMBER, 
	SCN_AT_ADD NUMBER
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.AQ$_TR_QT_S IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.SUBSCRIBER_ID IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.QUEUE_NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.ADDRESS IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.PROTOCOL IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.SUBSCRIBER_TYPE IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.RULE_NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.TRANS_NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.RULESET_NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.NEGATIVE_RULESET_NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.CSCN_LWM IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.CREATION_TIME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.MODIFICATION_TIME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.DELETION_TIME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.SCN_AT_REMOVE IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_S.SCN_AT_ADD IS '';




PROMPT *** Create  constraint SYS_C00118668 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ$_TR_QT_S MODIFY (SUBSCRIBER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118669 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ$_TR_QT_S MODIFY (QUEUE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118670 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ$_TR_QT_S ADD PRIMARY KEY (SUBSCRIBER_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C00118670 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.SYS_C00118670 ON BARSAQ.AQ$_TR_QT_S (SUBSCRIBER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AQ$_TR_QT_S ***
grant SELECT                                                                 on AQ$_TR_QT_S     to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/AQ$_TR_QT_S.sql =========*** End ***
PROMPT ===================================================================================== 
