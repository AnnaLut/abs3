

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/BRANCH_IN_BRANCH_SETTINGS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  table BRANCH_IN_BRANCH_SETTINGS ***
begin 
  execute immediate '
  CREATE TABLE CDB.BRANCH_IN_BRANCH_SETTINGS 
   (	BASE_BRANCH_ID NUMBER(5,0), 
	BRANCH_ID NUMBER(5,0), 
	CUSTOMER_ID NUMBER(10,0), 
	TRANSIT_ACCOUNT_ID NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.BRANCH_IN_BRANCH_SETTINGS IS '';
COMMENT ON COLUMN CDB.BRANCH_IN_BRANCH_SETTINGS.BASE_BRANCH_ID IS '';
COMMENT ON COLUMN CDB.BRANCH_IN_BRANCH_SETTINGS.BRANCH_ID IS '';
COMMENT ON COLUMN CDB.BRANCH_IN_BRANCH_SETTINGS.CUSTOMER_ID IS '';
COMMENT ON COLUMN CDB.BRANCH_IN_BRANCH_SETTINGS.TRANSIT_ACCOUNT_ID IS '';




PROMPT *** Create  constraint SYS_C00118858 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BRANCH_IN_BRANCH_SETTINGS MODIFY (BASE_BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118859 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BRANCH_IN_BRANCH_SETTINGS MODIFY (BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index BRANCH_CUSTOMER_IDX ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.BRANCH_CUSTOMER_IDX ON CDB.BRANCH_IN_BRANCH_SETTINGS (BASE_BRANCH_ID, BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH_IN_BRANCH_SETTINGS ***
grant SELECT                                                                 on BRANCH_IN_BRANCH_SETTINGS to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/BRANCH_IN_BRANCH_SETTINGS.sql =========
PROMPT ===================================================================================== 
