

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMS_LIST_TASKS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMS_LIST_TASKS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMS_LIST_TASKS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMS_LIST_TASKS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMS_LIST_TASKS 
   (	TASK_ID NUMBER(*,0), 
	TASK_ID_GROUP NUMBER(*,0), 
	TASK_ACTION VARCHAR2(500), 
	TASK_RANK NUMBER(*,0), 
	TASK_ACTIVE VARCHAR2(3), 
	TASK_TYPE VARCHAR2(50), 
	TASK_DESCRIPTION VARCHAR2(4000), 
	JOB_NAME VARCHAR2(30), 
	FAILED_ACTION VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMS_LIST_TASKS ***
 exec bpa.alter_policies('TMS_LIST_TASKS');


COMMENT ON TABLE BARS.TMS_LIST_TASKS IS '';
COMMENT ON COLUMN BARS.TMS_LIST_TASKS.TASK_ID IS '';
COMMENT ON COLUMN BARS.TMS_LIST_TASKS.TASK_ID_GROUP IS '';
COMMENT ON COLUMN BARS.TMS_LIST_TASKS.TASK_ACTION IS '';
COMMENT ON COLUMN BARS.TMS_LIST_TASKS.TASK_RANK IS '';
COMMENT ON COLUMN BARS.TMS_LIST_TASKS.TASK_ACTIVE IS '';
COMMENT ON COLUMN BARS.TMS_LIST_TASKS.TASK_TYPE IS '';
COMMENT ON COLUMN BARS.TMS_LIST_TASKS.TASK_DESCRIPTION IS '';
COMMENT ON COLUMN BARS.TMS_LIST_TASKS.JOB_NAME IS '';
COMMENT ON COLUMN BARS.TMS_LIST_TASKS.FAILED_ACTION IS '';




PROMPT *** Create  constraint FK_ID_GROUP ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_LIST_TASKS ADD CONSTRAINT FK_ID_GROUP FOREIGN KEY (TASK_ID_GROUP)
	  REFERENCES BARS.TMS_TASK_GROUPS (ID_GROUP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TASK_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_LIST_TASKS ADD CONSTRAINT PK_TASK_ID PRIMARY KEY (TASK_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TASK_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TASK_ID ON BARS.TMS_LIST_TASKS (TASK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMS_LIST_TASKS ***
grant SELECT                                                                 on TMS_LIST_TASKS  to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMS_LIST_TASKS.sql =========*** End **
PROMPT ===================================================================================== 
