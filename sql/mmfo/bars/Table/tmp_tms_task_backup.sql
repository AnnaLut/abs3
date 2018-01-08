

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_TMS_TASK_BACKUP.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_TMS_TASK_BACKUP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_TMS_TASK_BACKUP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_TMS_TASK_BACKUP 
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




PROMPT *** ALTER_POLICIES to TMP_TMS_TASK_BACKUP ***
 exec bpa.alter_policies('TMP_TMS_TASK_BACKUP');


COMMENT ON TABLE BARS.TMP_TMS_TASK_BACKUP IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK_BACKUP.SEQUENCE_NUMBER IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK_BACKUP.TASK_NAME IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK_BACKUP.TASK_DESCRIPTION IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK_BACKUP.BRANCH_PROCESSING_MODE IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK_BACKUP.ACTION_ON_FAILURE IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK_BACKUP.TASK_STATEMENT IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK_BACKUP.STATE_ID IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK_BACKUP.ID IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK_BACKUP.TASK_CODE IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK_BACKUP.TASK_TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_TMS_TASK_BACKUP.TASK_GROUP_ID IS '';




PROMPT *** Create  constraint SYS_C00119152 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK_BACKUP MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119153 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK_BACKUP MODIFY (TASK_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119154 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK_BACKUP MODIFY (TASK_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119155 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK_BACKUP MODIFY (TASK_GROUP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119160 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK_BACKUP MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119157 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK_BACKUP MODIFY (BRANCH_PROCESSING_MODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119158 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK_BACKUP MODIFY (ACTION_ON_FAILURE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119159 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK_BACKUP MODIFY (TASK_STATEMENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119156 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TMS_TASK_BACKUP MODIFY (TASK_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_TMS_TASK_BACKUP.sql =========*** E
PROMPT ===================================================================================== 
