

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_EPP_BATCH_REQUEST.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_EPP_BATCH_REQUEST ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_EPP_BATCH_REQUEST 
   (	ID NUMBER(10,0), 
	PFU_BATCH_ID NUMBER(10,0), 
	BATCH_DATE DATE, 
	BATCH_LINES_COUNT NUMBER(10,0), 
	BATCH_DATA CLOB, 
	DATA_SIGN VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (BATCH_DATA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_EPP_BATCH_REQUEST IS '';
COMMENT ON COLUMN PFU.PFU_EPP_BATCH_REQUEST.DATA_SIGN IS '';
COMMENT ON COLUMN PFU.PFU_EPP_BATCH_REQUEST.ID IS '';
COMMENT ON COLUMN PFU.PFU_EPP_BATCH_REQUEST.PFU_BATCH_ID IS '';
COMMENT ON COLUMN PFU.PFU_EPP_BATCH_REQUEST.BATCH_DATE IS '';
COMMENT ON COLUMN PFU.PFU_EPP_BATCH_REQUEST.BATCH_LINES_COUNT IS '';
COMMENT ON COLUMN PFU.PFU_EPP_BATCH_REQUEST.BATCH_DATA IS '';




PROMPT *** Create  constraint FK_EPP_REF_REQUEST ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_BATCH_REQUEST ADD CONSTRAINT FK_EPP_REF_REQUEST FOREIGN KEY (ID)
	  REFERENCES PFU.PFU_REQUEST (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111535 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_BATCH_REQUEST MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_EPP_BATCH_REQUEST ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_BATCH_REQUEST ADD CONSTRAINT PK_PFU_EPP_BATCH_REQUEST PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111537 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_BATCH_REQUEST MODIFY (BATCH_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111538 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_BATCH_REQUEST MODIFY (BATCH_LINES_COUNT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111536 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_BATCH_REQUEST MODIFY (PFU_BATCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_EPP_BATCH_REQUEST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_EPP_BATCH_REQUEST ON PFU.PFU_EPP_BATCH_REQUEST (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_EPP_BATCH_REQUEST.sql =========*** 
PROMPT ===================================================================================== 
