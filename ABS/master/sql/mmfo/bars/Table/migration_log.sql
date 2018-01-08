

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MIGRATION_LOG.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MIGRATION_LOG ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MIGRATION_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.MIGRATION_LOG 
   (	ID NUMBER, 
	MIGRATION_ID NUMBER, 
	MIGRATION_START_TIME DATE, 
	TABLE_NAME VARCHAR2(255), 
	OPERATION VARCHAR2(255), 
	ROW_COUNT NUMBER, 
	TASK_START_TIME TIMESTAMP (6), 
	TASK_END_TIME TIMESTAMP (6), 
	TIME_DURATION INTERVAL DAY (3) TO SECOND (3), 
	LOG_TYPE VARCHAR2(255), 
	LOG_MESSAGE VARCHAR2(4000), 
	ERROR_MESSAGE VARCHAR2(4000)
   ) PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS 
  TABLESPACE BRSSMLD 
  PARTITION BY RANGE (MIGRATION_START_TIME) INTERVAL (NUMTOYMINTERVAL(1,''MONTH'')) 
 (PARTITION P0  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSSMLD ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MIGRATION_LOG ***
 exec bpa.alter_policies('MIGRATION_LOG');


COMMENT ON TABLE BARS.MIGRATION_LOG IS '';
COMMENT ON COLUMN BARS.MIGRATION_LOG.ID IS '';
COMMENT ON COLUMN BARS.MIGRATION_LOG.MIGRATION_ID IS '';
COMMENT ON COLUMN BARS.MIGRATION_LOG.MIGRATION_START_TIME IS '';
COMMENT ON COLUMN BARS.MIGRATION_LOG.TABLE_NAME IS '';
COMMENT ON COLUMN BARS.MIGRATION_LOG.OPERATION IS '';
COMMENT ON COLUMN BARS.MIGRATION_LOG.ROW_COUNT IS '';
COMMENT ON COLUMN BARS.MIGRATION_LOG.TASK_START_TIME IS '';
COMMENT ON COLUMN BARS.MIGRATION_LOG.TASK_END_TIME IS '';
COMMENT ON COLUMN BARS.MIGRATION_LOG.TIME_DURATION IS '';
COMMENT ON COLUMN BARS.MIGRATION_LOG.LOG_TYPE IS '';
COMMENT ON COLUMN BARS.MIGRATION_LOG.LOG_MESSAGE IS '';
COMMENT ON COLUMN BARS.MIGRATION_LOG.ERROR_MESSAGE IS '';




PROMPT *** Create  constraint MIGRATION_LOG_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGRATION_LOG ADD CONSTRAINT MIGRATION_LOG_PK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOLOGGING 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index MIGRATION_LOG_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.MIGRATION_LOG_PK ON BARS.MIGRATION_LOG (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOLOGGING 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MIGRATION_LOG ***
grant SELECT                                                                 on MIGRATION_LOG   to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on MIGRATION_LOG   to FINMON;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MIGRATION_LOG.sql =========*** End ***
PROMPT ===================================================================================== 
