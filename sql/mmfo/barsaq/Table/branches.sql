

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/BRANCHES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table BRANCHES ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.BRANCHES 
   (	BANK_ID VARCHAR2(11), 
	BRANCH_ID VARCHAR2(30), 
	NAME VARCHAR2(70), 
	DATE_OPENED DATE DEFAULT trunc(sysdate), 
	DATE_CLOSED DATE, 
	NBU_CODE VARCHAR2(20), 
	DESCRIPTION VARCHAR2(128), 
	 CONSTRAINT PK_BRANCHES PRIMARY KEY (BANK_ID, BRANCH_ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.BRANCHES IS 'Відділення банків version 1.0';
COMMENT ON COLUMN BARSAQ.BRANCHES.BANK_ID IS 'Код банку';
COMMENT ON COLUMN BARSAQ.BRANCHES.BRANCH_ID IS 'Код відділення';
COMMENT ON COLUMN BARSAQ.BRANCHES.NAME IS 'Найменування відділення';
COMMENT ON COLUMN BARSAQ.BRANCHES.DATE_OPENED IS 'Дата відкриття';
COMMENT ON COLUMN BARSAQ.BRANCHES.DATE_CLOSED IS 'Дата закриття';
COMMENT ON COLUMN BARSAQ.BRANCHES.NBU_CODE IS 'Код відділення по довіднику НБУ SP_B040.dbf';
COMMENT ON COLUMN BARSAQ.BRANCHES.DESCRIPTION IS 'Опис';




PROMPT *** Create  constraint CC_BRANCHES_BANKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BRANCHES MODIFY (BANK_ID CONSTRAINT CC_BRANCHES_BANKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHES_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BRANCHES MODIFY (BRANCH_ID CONSTRAINT CC_BRANCHES_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BRANCHES MODIFY (NAME CONSTRAINT CC_BRANCHES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHES_DATEOPENED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BRANCHES MODIFY (DATE_OPENED CONSTRAINT CC_BRANCHES_DATEOPENED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BRANCHES ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BRANCHES ADD CONSTRAINT PK_BRANCHES PRIMARY KEY (BANK_ID, BRANCH_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRANCHES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_BRANCHES ON BARSAQ.BRANCHES (BANK_ID, BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCHES ***
grant SELECT                                                                 on BRANCHES        to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/BRANCHES.sql =========*** End *** ==
PROMPT ===================================================================================== 
