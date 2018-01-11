

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/BARS_TRANSACTION.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table BARS_TRANSACTION ***
begin 
  execute immediate '
  CREATE TABLE CDB.BARS_TRANSACTION 
   (	ID NUMBER(10,0), 
	OBJECT_ID NUMBER(10,0), 
	OPERATION_ID NUMBER(10,0), 
	TRANSACTION_TYPE NUMBER(5,0), 
	STATE NUMBER(5,0), 
	PRIORITY_GROUP NUMBER(5,0), 
	FAIL_COUNTER NUMBER(5,0), 
	SYS_TIME DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.BARS_TRANSACTION IS '';
COMMENT ON COLUMN CDB.BARS_TRANSACTION.ID IS '';
COMMENT ON COLUMN CDB.BARS_TRANSACTION.OBJECT_ID IS '';
COMMENT ON COLUMN CDB.BARS_TRANSACTION.OPERATION_ID IS '';
COMMENT ON COLUMN CDB.BARS_TRANSACTION.TRANSACTION_TYPE IS '';
COMMENT ON COLUMN CDB.BARS_TRANSACTION.STATE IS '';
COMMENT ON COLUMN CDB.BARS_TRANSACTION.PRIORITY_GROUP IS '';
COMMENT ON COLUMN CDB.BARS_TRANSACTION.FAIL_COUNTER IS '';
COMMENT ON COLUMN CDB.BARS_TRANSACTION.SYS_TIME IS '';




PROMPT *** Create  constraint PK_BARS_TRANSACTION ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_TRANSACTION ADD CONSTRAINT PK_BARS_TRANSACTION PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118872 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_TRANSACTION MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118873 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_TRANSACTION MODIFY (OBJECT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118874 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_TRANSACTION MODIFY (TRANSACTION_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118875 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_TRANSACTION MODIFY (STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118876 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_TRANSACTION MODIFY (FAIL_COUNTER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118877 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_TRANSACTION MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BARS_TRANSACTION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_BARS_TRANSACTION ON CDB.BARS_TRANSACTION (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index BARS_TRANSACTION_IDX ***
begin   
 execute immediate '
  CREATE INDEX CDB.BARS_TRANSACTION_IDX ON CDB.BARS_TRANSACTION (OPERATION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BARS_TRANSACTION ***
grant SELECT                                                                 on BARS_TRANSACTION to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/BARS_TRANSACTION.sql =========*** End *
PROMPT ===================================================================================== 
