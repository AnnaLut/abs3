

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/CLAIM_TRACKING.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table CLAIM_TRACKING ***
begin 
  execute immediate '
  CREATE TABLE CDB.CLAIM_TRACKING 
   (	ID NUMBER(10,0), 
	CLAIM_ID NUMBER(10,0), 
	STATE NUMBER(5,0), 
	SYS_TIME DATE, 
	COMMENT_TEXT VARCHAR2(1000 CHAR), 
	STACK_TRACE CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (STACK_TRACE) STORE AS BASICFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.CLAIM_TRACKING IS '';
COMMENT ON COLUMN CDB.CLAIM_TRACKING.ID IS '';
COMMENT ON COLUMN CDB.CLAIM_TRACKING.CLAIM_ID IS '';
COMMENT ON COLUMN CDB.CLAIM_TRACKING.STATE IS '';
COMMENT ON COLUMN CDB.CLAIM_TRACKING.SYS_TIME IS '';
COMMENT ON COLUMN CDB.CLAIM_TRACKING.COMMENT_TEXT IS '';
COMMENT ON COLUMN CDB.CLAIM_TRACKING.STACK_TRACE IS '';




PROMPT *** Create  constraint SYS_C00118943 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_TRACKING MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118944 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_TRACKING MODIFY (CLAIM_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118945 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_TRACKING MODIFY (STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118946 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_TRACKING MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CLAIM_TRACKING ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_TRACKING ADD CONSTRAINT PK_CLAIM_TRACKING PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLAIM_TRACKING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_CLAIM_TRACKING ON CDB.CLAIM_TRACKING (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index CLAIM_TRACKING_IDX ***
begin   
 execute immediate '
  CREATE INDEX CDB.CLAIM_TRACKING_IDX ON CDB.CLAIM_TRACKING (CLAIM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLAIM_TRACKING ***
grant SELECT                                                                 on CLAIM_TRACKING  to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/CLAIM_TRACKING.sql =========*** End ***
PROMPT ===================================================================================== 
