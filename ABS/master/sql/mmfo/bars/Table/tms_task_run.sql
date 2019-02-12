

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMS_TASK_RUN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMS_TASK_RUN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMS_TASK_RUN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMS_TASK_RUN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMS_TASK_RUN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMS_TASK_RUN ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMS_TASK_RUN 
   (	ID NUMBER(38,0), 
	RUN_ID NUMBER(38,0), 
	TASK_ID NUMBER(38,0), 
	BRANCH VARCHAR2(30 CHAR), 
	WRAPPER_JOB_NAME VARCHAR2(30 CHAR), 
	START_TIME DATE, 
	FINISH_TIME DATE, 
	STATE_ID NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMS_TASK_RUN ***
 exec bpa.alter_policies('TMS_TASK_RUN');


COMMENT ON TABLE BARS.TMS_TASK_RUN IS '';
COMMENT ON COLUMN BARS.TMS_TASK_RUN.ID IS '';
COMMENT ON COLUMN BARS.TMS_TASK_RUN.RUN_ID IS '';
COMMENT ON COLUMN BARS.TMS_TASK_RUN.TASK_ID IS '';
COMMENT ON COLUMN BARS.TMS_TASK_RUN.BRANCH IS '';
COMMENT ON COLUMN BARS.TMS_TASK_RUN.WRAPPER_JOB_NAME IS '';
COMMENT ON COLUMN BARS.TMS_TASK_RUN.START_TIME IS '';
COMMENT ON COLUMN BARS.TMS_TASK_RUN.FINISH_TIME IS '';
COMMENT ON COLUMN BARS.TMS_TASK_RUN.STATE_ID IS '';




PROMPT *** Create  constraint SYS_C0035453 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_RUN MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035454 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_RUN MODIFY (RUN_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035455 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_RUN MODIFY (TASK_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035456 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_RUN MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TMS_TASK_RUN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_RUN ADD CONSTRAINT PK_TMS_TASK_RUN PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMS_TASK_RUN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMS_TASK_RUN ON BARS.TMS_TASK_RUN (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_TMS_TASK_RUN_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_TMS_TASK_RUN_ID ON BARS.TMS_TASK_RUN (RUN_ID, TASK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMS_TASK_RUN ***
grant SELECT                                                                 on TMS_TASK_RUN    to BARSREADER_ROLE;
grant SELECT                                                                 on TMS_TASK_RUN    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMS_TASK_RUN.sql =========*** End *** 
PROMPT ===================================================================================== 
