

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_STATS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_STATS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_STATS 
   (	ID NUMBER, 
	UPL_BANKDATE DATE, 
	GROUP_ID NUMBER, 
	FILE_ID NUMBER, 
	FILE_CODE VARCHAR2(50), 
	SQL_ID NUMBER, 
	START_TIME DATE, 
	STOP_TIME DATE, 
	STATUS_ID NUMBER, 
	PARAMS VARCHAR2(200), 
	UPL_ERRORS VARCHAR2(500), 
	ROWS_UPLOADED NUMBER, 
	START_ARC_TIME DATE, 
	STOP_ARC_TIME DATE, 
	ARC_LOGMESS VARCHAR2(2000), 
	START_FTP_TIME DATE, 
	STOP_FTP_TIME DATE, 
	FTP_LOGMESS VARCHAR2(2000), 
	PARENT_ID NUMBER, 
	FILE_NAME VARCHAR2(200), 
	JOB_ID NUMBER, 
	REC_TYPE VARCHAR2(10), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_STATS IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.UPL_BANKDATE IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.GROUP_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.FILE_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.FILE_CODE IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.SQL_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.START_TIME IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.STOP_TIME IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.STATUS_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.PARAMS IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.UPL_ERRORS IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.ROWS_UPLOADED IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.START_ARC_TIME IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.STOP_ARC_TIME IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.ARC_LOGMESS IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.START_FTP_TIME IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.STOP_FTP_TIME IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.FTP_LOGMESS IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.PARENT_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.FILE_NAME IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.JOB_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.REC_TYPE IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS.KF IS '';




PROMPT *** Create  constraint UPL_STATS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_STATS ADD CONSTRAINT UPL_STATS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UPLSTATSGROUPID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_STATS ADD CONSTRAINT FK_UPLSTATSGROUPID FOREIGN KEY (GROUP_ID)
	  REFERENCES BARSUPL.UPL_GROUPS (GROUP_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UPLSTATSSQLID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_STATS ADD CONSTRAINT FK_UPLSTATSSQLID FOREIGN KEY (SQL_ID)
	  REFERENCES BARSUPL.UPL_SQL (SQL_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UPLSTATSFILEID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_STATS ADD CONSTRAINT FK_UPLSTATSFILEID FOREIGN KEY (FILE_ID)
	  REFERENCES BARSUPL.UPL_FILES (FILE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STATS_UPLREGIONS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_STATS ADD CONSTRAINT FK_STATS_UPLREGIONS FOREIGN KEY (KF)
	  REFERENCES BARSUPL.UPL_REGIONS (KF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UPLSTATSPARENTID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_STATS ADD CONSTRAINT FK_UPLSTATSPARENTID FOREIGN KEY (PARENT_ID)
	  REFERENCES BARSUPL.UPL_STATS (ID) ON DELETE CASCADE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UPLSTATSRECORDTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_STATS ADD CONSTRAINT FK_UPLSTATSRECORDTYPE FOREIGN KEY (REC_TYPE)
	  REFERENCES BARSUPL.UPL_STATS_RECORDTYPE (REC_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033232 ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_STATS MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UPLSTATSSTATUSID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_STATS ADD CONSTRAINT FK_UPLSTATSSTATUSID FOREIGN KEY (STATUS_ID)
	  REFERENCES BARSUPL.UPL_PROCESS_STATUS (STATUS_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UPL_STATS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.UPL_STATS ON BARSUPL.UPL_STATS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_STATS ***
grant DELETE,INSERT,SELECT                                                   on UPL_STATS       to BARS;
grant DELETE,INSERT,SELECT                                                   on UPL_STATS       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_STATS.sql =========*** End *** 
PROMPT ===================================================================================== 
