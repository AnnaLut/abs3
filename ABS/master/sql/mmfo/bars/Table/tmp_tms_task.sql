

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_TMS_TASK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_TMS_TASK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_TMS_TASK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_TMS_TASK 
   (	ID NUMBER(38,0), 
	TASK_CODE VARCHAR2(255 CHAR), 
	TASK_TYPE_ID NUMBER(5,0), 
	TASK_GROUP_ID NUMBER(5,0), 
	SEQUENCE_NUMBER NUMBER(5,0), 
	TASK_NAME VARCHAR2(300 CHAR), 
	TASK_DESCRIPTION VARCHAR2(4000), 
	BRANCH_PROCESSING_MODE NUMBER(5,0), 
	ACTION_ON_FAILURE NUMBER(5,0), 
	TASK_STATEMENT VARCHAR2(4000), 
	STATE_ID NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_TMS_TASK ***
 exec bpa.alter_policies('TMP_TMS_TASK');


COMMENT ON TABLE BARS.TMP_TMS_TASK IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK.ID IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK.TASK_CODE IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK.TASK_TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK.TASK_GROUP_ID IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK.SEQUENCE_NUMBER IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK.TASK_NAME IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK.TASK_DESCRIPTION IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK.BRANCH_PROCESSING_MODE IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK.ACTION_ON_FAILURE IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK.TASK_STATEMENT IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK.STATE_ID IS '';




PROMPT *** Create  constraint SYS_C00119129 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119130 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK MODIFY (TASK_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119131 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK MODIFY (TASK_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119132 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK MODIFY (TASK_GROUP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119133 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK MODIFY (TASK_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119134 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK MODIFY (BRANCH_PROCESSING_MODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119135 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK MODIFY (ACTION_ON_FAILURE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119136 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK MODIFY (TASK_STATEMENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119137 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_TMS_TASK ***
grant SELECT                                                                 on TMP_TMS_TASK    to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_TMS_TASK    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_TMS_TASK.sql =========*** End *** 
PROMPT ===================================================================================== 
