

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADM_RESOURCE_TYPE_RELATION.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADM_RESOURCE_TYPE_RELATION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADM_RESOURCE_TYPE_RELATION'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADM_RESOURCE_TYPE_RELATION ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADM_RESOURCE_TYPE_RELATION 
   (	GRANTEE_TYPE_ID NUMBER(5,0), 
	RESOURCE_TYPE_ID NUMBER(5,0), 
	MUST_BE_APPROVED CHAR(1), 
	ACCESS_MODE_LIST_ID NUMBER(5,0), 
	NO_ACCESS_ITEM_ID NUMBER(5,0), 
	ON_CHANGE_EVENT_HANDLER VARCHAR2(100 CHAR), 
	ON_RESOLVE_EVENT_HANDLER VARCHAR2(100 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADM_RESOURCE_TYPE_RELATION ***
 exec bpa.alter_policies('ADM_RESOURCE_TYPE_RELATION');


COMMENT ON TABLE BARS.ADM_RESOURCE_TYPE_RELATION IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_TYPE_RELATION.GRANTEE_TYPE_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_TYPE_RELATION.RESOURCE_TYPE_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_TYPE_RELATION.MUST_BE_APPROVED IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_TYPE_RELATION.ACCESS_MODE_LIST_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_TYPE_RELATION.NO_ACCESS_ITEM_ID IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_TYPE_RELATION.ON_CHANGE_EVENT_HANDLER IS '';
COMMENT ON COLUMN BARS.ADM_RESOURCE_TYPE_RELATION.ON_RESOLVE_EVENT_HANDLER IS '';




PROMPT *** Create  constraint SYS_C0025735 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE_RELATION MODIFY (GRANTEE_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025736 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE_RELATION MODIFY (RESOURCE_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025737 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE_RELATION MODIFY (MUST_BE_APPROVED NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025738 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE_RELATION MODIFY (ACCESS_MODE_LIST_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025739 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE_RELATION MODIFY (NO_ACCESS_ITEM_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ADM_RESOURCE_TYPE_RELATION ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADM_RESOURCE_TYPE_RELATION ADD CONSTRAINT PK_ADM_RESOURCE_TYPE_RELATION PRIMARY KEY (GRANTEE_TYPE_ID, RESOURCE_TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ADM_RESOURCE_TYPE_RELATION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ADM_RESOURCE_TYPE_RELATION ON BARS.ADM_RESOURCE_TYPE_RELATION (GRANTEE_TYPE_ID, RESOURCE_TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADM_RESOURCE_TYPE_RELATION ***
grant SELECT                                                                 on ADM_RESOURCE_TYPE_RELATION to BARSREADER_ROLE;
grant SELECT                                                                 on ADM_RESOURCE_TYPE_RELATION to BARS_DM;
grant SELECT                                                                 on ADM_RESOURCE_TYPE_RELATION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADM_RESOURCE_TYPE_RELATION.sql =======
PROMPT ===================================================================================== 
