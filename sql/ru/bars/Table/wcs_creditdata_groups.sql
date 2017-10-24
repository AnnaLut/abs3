

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_CREDITDATA_GROUPS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_CREDITDATA_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_CREDITDATA_GROUPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_CREDITDATA_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_CREDITDATA_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_CREDITDATA_GROUPS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	DNSHOW_IF VARCHAR2(4000), 
	ORD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_CREDITDATA_GROUPS ***
 exec bpa.alter_policies('WCS_CREDITDATA_GROUPS');


COMMENT ON TABLE BARS.WCS_CREDITDATA_GROUPS IS '';
COMMENT ON COLUMN BARS.WCS_CREDITDATA_GROUPS.ID IS '';
COMMENT ON COLUMN BARS.WCS_CREDITDATA_GROUPS.NAME IS '';
COMMENT ON COLUMN BARS.WCS_CREDITDATA_GROUPS.DNSHOW_IF IS '';
COMMENT ON COLUMN BARS.WCS_CREDITDATA_GROUPS.ORD IS '';




PROMPT *** Create  constraint CC_CRDGROUPS_ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_GROUPS ADD CONSTRAINT CC_CRDGROUPS_ORD_NN CHECK (ORD IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CRDGROUPS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_GROUPS ADD CONSTRAINT CC_CRDGROUPS_NAME_NN CHECK (NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CRDDATAGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_GROUPS ADD CONSTRAINT PK_CRDDATAGROUPS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177056 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_GROUPS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CRDDATAGROUPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CRDDATAGROUPS ON BARS.WCS_CREDITDATA_GROUPS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_CREDITDATA_GROUPS.sql =========***
PROMPT ===================================================================================== 
