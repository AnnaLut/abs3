

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/TRANSACTION_TRACKING.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSACTION_TRACKING ***
begin 
  execute immediate '
  CREATE TABLE CDB.TRANSACTION_TRACKING 
   (	ID NUMBER(10,0), 
	TRANSACTION_ID NUMBER(10,0), 
	STATE NUMBER(5,0), 
	SYS_TIME DATE, 
	ERROR_MESSAGE CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (ERROR_MESSAGE) STORE AS BASICFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.TRANSACTION_TRACKING IS '';
COMMENT ON COLUMN CDB.TRANSACTION_TRACKING.ID IS '';
COMMENT ON COLUMN CDB.TRANSACTION_TRACKING.TRANSACTION_ID IS '';
COMMENT ON COLUMN CDB.TRANSACTION_TRACKING.STATE IS '';
COMMENT ON COLUMN CDB.TRANSACTION_TRACKING.SYS_TIME IS '';
COMMENT ON COLUMN CDB.TRANSACTION_TRACKING.ERROR_MESSAGE IS '';




PROMPT *** Create  constraint SYS_C00118938 ***
begin   
 execute immediate '
  ALTER TABLE CDB.TRANSACTION_TRACKING MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118939 ***
begin   
 execute immediate '
  ALTER TABLE CDB.TRANSACTION_TRACKING MODIFY (TRANSACTION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118940 ***
begin   
 execute immediate '
  ALTER TABLE CDB.TRANSACTION_TRACKING MODIFY (STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TRANSACTION_TRACKING ***
begin   
 execute immediate '
  ALTER TABLE CDB.TRANSACTION_TRACKING ADD CONSTRAINT PK_TRANSACTION_TRACKING PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANSACTION_TRACKING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_TRANSACTION_TRACKING ON CDB.TRANSACTION_TRACKING (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index TRANSACTION_TRACKING_IDX ***
begin   
 execute immediate '
  CREATE INDEX CDB.TRANSACTION_TRACKING_IDX ON CDB.TRANSACTION_TRACKING (TRANSACTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TRANSACTION_TRACKING ***
grant SELECT                                                                 on TRANSACTION_TRACKING to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/TRANSACTION_TRACKING.sql =========*** E
PROMPT ===================================================================================== 
