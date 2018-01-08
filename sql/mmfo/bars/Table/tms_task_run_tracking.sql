

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMS_TASK_RUN_TRACKING.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMS_TASK_RUN_TRACKING ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMS_TASK_RUN_TRACKING'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMS_TASK_RUN_TRACKING'', ''FILIAL'' , null, null, ''E'', ''E'');
               bpa.alter_policy_info(''TMS_TASK_RUN_TRACKING'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMS_TASK_RUN_TRACKING ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMS_TASK_RUN_TRACKING 
   (	ID NUMBER(38,0), 
	TASK_RUN_ID NUMBER(38,0), 
	STATE_ID NUMBER(5,0), 
	SYS_TIME DATE, 
	USER_ID NUMBER(38,0), 
	DETAILS CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (DETAILS) STORE AS BASICFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMS_TASK_RUN_TRACKING ***
 exec bpa.alter_policies('TMS_TASK_RUN_TRACKING');


COMMENT ON TABLE BARS.TMS_TASK_RUN_TRACKING IS '';
COMMENT ON COLUMN BARS.TMS_TASK_RUN_TRACKING.ID IS '';
COMMENT ON COLUMN BARS.TMS_TASK_RUN_TRACKING.TASK_RUN_ID IS '';
COMMENT ON COLUMN BARS.TMS_TASK_RUN_TRACKING.STATE_ID IS '';
COMMENT ON COLUMN BARS.TMS_TASK_RUN_TRACKING.SYS_TIME IS '';
COMMENT ON COLUMN BARS.TMS_TASK_RUN_TRACKING.USER_ID IS '';
COMMENT ON COLUMN BARS.TMS_TASK_RUN_TRACKING.DETAILS IS '';




PROMPT *** Create  constraint SYS_C0035460 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_RUN_TRACKING MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035461 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_RUN_TRACKING MODIFY (TASK_RUN_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035462 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_RUN_TRACKING MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035463 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_RUN_TRACKING MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TMS_TASK_RUN_TRACKING ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_RUN_TRACKING ADD CONSTRAINT PK_TMS_TASK_RUN_TRACKING PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMS_TASK_RUN_TRACKING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMS_TASK_RUN_TRACKING ON BARS.TMS_TASK_RUN_TRACKING (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMS_TASK_RUN_TRACKING ***
grant SELECT                                                                 on TMS_TASK_RUN_TRACKING to BARSREADER_ROLE;
grant SELECT                                                                 on TMS_TASK_RUN_TRACKING to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMS_TASK_RUN_TRACKING.sql =========***
PROMPT ===================================================================================== 
