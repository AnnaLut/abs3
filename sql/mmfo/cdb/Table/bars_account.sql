

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/BARS_ACCOUNT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table BARS_ACCOUNT ***
begin 
  execute immediate '
  CREATE TABLE CDB.BARS_ACCOUNT 
   (	ID NUMBER(10,0), 
	BALANCE_ACCOUNT VARCHAR2(5 CHAR), 
	ACCOUNT_NUMBER VARCHAR2(14 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.BARS_ACCOUNT IS '';
COMMENT ON COLUMN CDB.BARS_ACCOUNT.ID IS '';
COMMENT ON COLUMN CDB.BARS_ACCOUNT.BALANCE_ACCOUNT IS '';
COMMENT ON COLUMN CDB.BARS_ACCOUNT.ACCOUNT_NUMBER IS '';




PROMPT *** Create  constraint PK_BARS_ACCOUNT ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_ACCOUNT ADD CONSTRAINT PK_BARS_ACCOUNT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118861 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_ACCOUNT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BARS_ACCOUNT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_BARS_ACCOUNT ON CDB.BARS_ACCOUNT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index BARS_ACCOUNT_IDX ***
begin   
 execute immediate '
  CREATE INDEX CDB.BARS_ACCOUNT_IDX ON CDB.BARS_ACCOUNT (ACCOUNT_NUMBER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BARS_ACCOUNT ***
grant SELECT                                                                 on BARS_ACCOUNT    to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/BARS_ACCOUNT.sql =========*** End *** =
PROMPT ===================================================================================== 
