

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/BRANCH.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  table BRANCH ***
begin 
  execute immediate '
  CREATE TABLE CDB.BRANCH 
   (	ID NUMBER(5,0), 
	BRANCH_CODE VARCHAR2(30 CHAR), 
	BRANCH_NAME VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.BRANCH IS '';
COMMENT ON COLUMN CDB.BRANCH.ID IS '';
COMMENT ON COLUMN CDB.BRANCH.BRANCH_CODE IS '';
COMMENT ON COLUMN CDB.BRANCH.BRANCH_NAME IS '';




PROMPT *** Create  constraint PK_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE CDB.BRANCH ADD CONSTRAINT PK_BRANCH PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint AK_KEY_2_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE CDB.BRANCH ADD CONSTRAINT AK_KEY_2_BRANCH UNIQUE (BRANCH_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118862 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BRANCH MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118863 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BRANCH MODIFY (BRANCH_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRANCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_BRANCH ON CDB.BRANCH (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index AK_KEY_2_BRANCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.AK_KEY_2_BRANCH ON CDB.BRANCH (BRANCH_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH ***
grant SELECT                                                                 on BRANCH          to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/BRANCH.sql =========*** End *** =======
PROMPT ===================================================================================== 
