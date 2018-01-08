

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/AQ$_AQ_REFSYNC_TBL_S.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  table AQ$_AQ_REFSYNC_TBL_S ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.AQ$_AQ_REFSYNC_TBL_S 
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


COMMENT ON TABLE BARSAQ.AQ$_AQ_REFSYNC_TBL_S IS '';
COMMENT ON COLUMN BARSAQ.AQ$_AQ_REFSYNC_TBL_S.SUBSCRIBER_ID IS '';
COMMENT ON COLUMN BARSAQ.AQ$_AQ_REFSYNC_TBL_S.QUEUE_NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_AQ_REFSYNC_TBL_S.NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_AQ_REFSYNC_TBL_S.ADDRESS IS '';
COMMENT ON COLUMN BARSAQ.AQ$_AQ_REFSYNC_TBL_S.PROTOCOL IS '';
COMMENT ON COLUMN BARSAQ.AQ$_AQ_REFSYNC_TBL_S.SUBSCRIBER_TYPE IS '';
COMMENT ON COLUMN BARSAQ.AQ$_AQ_REFSYNC_TBL_S.RULE_NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_AQ_REFSYNC_TBL_S.TRANS_NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_AQ_REFSYNC_TBL_S.RULESET_NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_AQ_REFSYNC_TBL_S.NEGATIVE_RULESET_NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_AQ_REFSYNC_TBL_S.CREATION_TIME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_AQ_REFSYNC_TBL_S.MODIFICATION_TIME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_AQ_REFSYNC_TBL_S.DELETION_TIME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_AQ_REFSYNC_TBL_S.SCN_AT_REMOVE IS '';
COMMENT ON COLUMN BARSAQ.AQ$_AQ_REFSYNC_TBL_S.SCN_AT_ADD IS '';




PROMPT *** Create  constraint SYS_C0010717 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ$_AQ_REFSYNC_TBL_S ADD PRIMARY KEY (SUBSCRIBER_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010421 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ$_AQ_REFSYNC_TBL_S MODIFY (SUBSCRIBER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010422 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ$_AQ_REFSYNC_TBL_S MODIFY (QUEUE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0010717 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.SYS_C0010717 ON BARSAQ.AQ$_AQ_REFSYNC_TBL_S (SUBSCRIBER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/AQ$_AQ_REFSYNC_TBL_S.sql =========**
PROMPT ===================================================================================== 
