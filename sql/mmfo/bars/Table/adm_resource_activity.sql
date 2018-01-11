

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADM_RESOURCE_ACTIVITY.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADM_RESOURCE_ACTIVITY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADM_RESOURCE_ACTIVITY'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADM_RESOURCE_ACTIVITY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADM_RESOURCE_ACTIVITY 
   (	ID NUMBER(38,0), 
	GRANTEE_TYPE_ID NUMBER(5,0), 
	GRANTEE_ID NUMBER(38,0), 
	RESOURCE_TYPE_ID NUMBER(5,0), 
	RESOURCE_ID NUMBER(38,0), 
	ACCESS_MODE_ID NUMBER(5,0), 
	ACTION_TIME DATE, 
	ACTION_USER_ID NUMBER(38,0), 
	RESOLUTION_TYPE_ID NUMBER(5,0), 
	RESOLUTION_TIME DATE, 
	RESOLUTION_USER_ID NUMBER(38,0), 
	RESOLUTION_COMMENT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADM_RESOURCE_ACTIVITY ***
 exec bpa.alter_policies('ADM_RESOURCE_ACTIVITY');


COMMENT ON TABLE BARS.ADM_RESOURCE_ACTIVITY IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_ACTIVITY.ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_ACTIVITY.GRANTEE_TYPE_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_ACTIVITY.GRANTEE_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_ACTIVITY.RESOURCE_TYPE_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_ACTIVITY.RESOURCE_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_ACTIVITY.ACCESS_MODE_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_ACTIVITY.ACTION_TIME IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_ACTIVITY.ACTION_USER_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_ACTIVITY.RESOLUTION_TYPE_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_ACTIVITY.RESOLUTION_TIME IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_ACTIVITY.RESOLUTION_USER_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_ACTIVITY.RESOLUTION_COMMENT IS '';




PROMPT *** Create  constraint SYS_C0025750 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_ACTIVITY MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025751 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_ACTIVITY MODIFY (GRANTEE_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025752 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_ACTIVITY MODIFY (GRANTEE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025753 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_ACTIVITY MODIFY (RESOURCE_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025754 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_ACTIVITY MODIFY (RESOURCE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025755 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_ACTIVITY MODIFY (ACCESS_MODE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025756 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_ACTIVITY MODIFY (ACTION_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025757 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_ACTIVITY MODIFY (ACTION_USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ADM_RESOURCE_ACTIVITY ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_ACTIVITY ADD CONSTRAINT PK_ADM_RESOURCE_ACTIVITY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ADM_RESOURCE_ACTIVITY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ADM_RESOURCE_ACTIVITY ON BARS.ADM_RESOURCE_ACTIVITY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index ADM_RESOURCE_ACTIVITY_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.ADM_RESOURCE_ACTIVITY_IDX ON BARS.ADM_RESOURCE_ACTIVITY (GRANTEE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index ADM_RESOURCE_ACTIVITY_IDX2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.ADM_RESOURCE_ACTIVITY_IDX2 ON BARS.ADM_RESOURCE_ACTIVITY (RESOURCE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADM_RESOURCE_ACTIVITY ***
grant SELECT                                                                 on ADM_RESOURCE_ACTIVITY to BARSREADER_ROLE;
grant SELECT                                                                 on ADM_RESOURCE_ACTIVITY to BARS_DM;
grant SELECT                                                                 on ADM_RESOURCE_ACTIVITY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADM_RESOURCE_ACTIVITY.sql =========***
PROMPT ===================================================================================== 
