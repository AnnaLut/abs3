

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADM_RESOURCE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADM_RESOURCE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADM_RESOURCE'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADM_RESOURCE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADM_RESOURCE 
   (	GRANTEE_TYPE_ID NUMBER(5,0), 
	GRANTEE_ID NUMBER(38,0), 
	RESOURCE_TYPE_ID NUMBER(5,0), 
	RESOURCE_ID NUMBER(38,0), 
	ACCESS_MODE_ID NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADM_RESOURCE ***
 exec bpa.alter_policies('ADM_RESOURCE');


COMMENT ON TABLE BARS.ADM_RESOURCE IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE.GRANTEE_TYPE_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE.GRANTEE_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE.RESOURCE_TYPE_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE.RESOURCE_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE.ACCESS_MODE_ID IS '';




PROMPT *** Create  constraint SYS_C0025743 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE MODIFY (GRANTEE_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025744 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE MODIFY (GRANTEE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025745 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE MODIFY (RESOURCE_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025746 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE MODIFY (RESOURCE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ADM_RESOURCE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE ADD CONSTRAINT PK_ADM_RESOURCE PRIMARY KEY (GRANTEE_TYPE_ID, RESOURCE_TYPE_ID, GRANTEE_ID, RESOURCE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 2 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRANTEE_TYPE_REF_RES_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE ADD CONSTRAINT FK_GRANTEE_TYPE_REF_RES_TYPE FOREIGN KEY (GRANTEE_TYPE_ID)
	  REFERENCES BARS.ADM_RESOURCE_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRANTED_TYPE_REF_RES_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE ADD CONSTRAINT FK_GRANTED_TYPE_REF_RES_TYPE FOREIGN KEY (RESOURCE_TYPE_ID)
	  REFERENCES BARS.ADM_RESOURCE_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ADM_RESOURCE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ADM_RESOURCE ON BARS.ADM_RESOURCE (GRANTEE_TYPE_ID, RESOURCE_TYPE_ID, GRANTEE_ID, RESOURCE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 2 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index ADM_RESOURCE_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.ADM_RESOURCE_IDX ON BARS.ADM_RESOURCE (RESOURCE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADM_RESOURCE ***
grant SELECT                                                                 on ADM_RESOURCE    to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADM_RESOURCE.sql =========*** End *** 
PROMPT ===================================================================================== 
