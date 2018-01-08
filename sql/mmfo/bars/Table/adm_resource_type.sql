

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADM_RESOURCE_TYPE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADM_RESOURCE_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADM_RESOURCE_TYPE'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADM_RESOURCE_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADM_RESOURCE_TYPE 
   (	ID NUMBER(5,0), 
	RESOURCE_CODE VARCHAR2(30 CHAR), 
	RESOURCE_NAME VARCHAR2(300 CHAR), 
	SOURCE_TABLE_NAME VARCHAR2(4000 CHAR), 
	SOURCE_ID_COLUMN_NAME VARCHAR2(30 CHAR), 
	SOURCE_CODE_COLUMN_NAME VARCHAR2(4000 CHAR), 
	SOURCE_NAME_COLUMN_NAME VARCHAR2(4000 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADM_RESOURCE_TYPE ***
 exec bpa.alter_policies('ADM_RESOURCE_TYPE');


COMMENT ON TABLE BARS.ADM_RESOURCE_TYPE IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_TYPE.ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_TYPE.RESOURCE_CODE IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_TYPE.RESOURCE_NAME IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_TYPE.SOURCE_TABLE_NAME IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_TYPE.SOURCE_ID_COLUMN_NAME IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_TYPE.SOURCE_CODE_COLUMN_NAME IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_TYPE.SOURCE_NAME_COLUMN_NAME IS '';




PROMPT *** Create  constraint SYS_C0025726 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025727 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE MODIFY (RESOURCE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025728 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE MODIFY (RESOURCE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025729 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE MODIFY (SOURCE_TABLE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025730 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE MODIFY (SOURCE_ID_COLUMN_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025731 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE MODIFY (SOURCE_CODE_COLUMN_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025732 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE MODIFY (SOURCE_NAME_COLUMN_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ADM_RESOURCE_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE ADD CONSTRAINT PK_ADM_RESOURCE_TYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_ADM_RESOURCE_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE ADD CONSTRAINT UK_ADM_RESOURCE_TYPE UNIQUE (RESOURCE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ADM_RESOURCE_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ADM_RESOURCE_TYPE ON BARS.ADM_RESOURCE_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_ADM_RESOURCE_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_ADM_RESOURCE_TYPE ON BARS.ADM_RESOURCE_TYPE (RESOURCE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADM_RESOURCE_TYPE ***
grant SELECT                                                                 on ADM_RESOURCE_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on ADM_RESOURCE_TYPE to BARS_DM;
grant SELECT                                                                 on ADM_RESOURCE_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADM_RESOURCE_TYPE.sql =========*** End
PROMPT ===================================================================================== 
