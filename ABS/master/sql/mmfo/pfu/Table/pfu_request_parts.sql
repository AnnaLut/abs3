

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_REQUEST_PARTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_REQUEST_PARTS ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_REQUEST_PARTS 
   (	SESSION_ID NUMBER(10,0), 
	REQUEST_ID NUMBER(10,0), 
	PART NUMBER(4,0), 
	SYS_TIME DATE, 
	PART_DATA BLOB, 
	PART_DATA_CLOB CLOB, 
	STATE VARCHAR2(30)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (PART_DATA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (PART_DATA_CLOB) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_REQUEST_PARTS IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_PARTS.SESSION_ID IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_PARTS.REQUEST_ID IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_PARTS.PART IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_PARTS.SYS_TIME IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_PARTS.PART_DATA IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_PARTS.PART_DATA_CLOB IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_PARTS.STATE IS '';




PROMPT *** Create  constraint FK_PFU_REQUEST_PARTS_REQUESTID ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_PARTS ADD CONSTRAINT FK_PFU_REQUEST_PARTS_REQUESTID FOREIGN KEY (REQUEST_ID)
	  REFERENCES PFU.PFU_REQUEST (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_REQUEST_PARTS ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_PARTS ADD CONSTRAINT PK_PFU_REQUEST_PARTS PRIMARY KEY (REQUEST_ID, PART)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111511 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_PARTS MODIFY (PART NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111510 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_PARTS MODIFY (REQUEST_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_REQUEST_PARTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_REQUEST_PARTS ON PFU.PFU_REQUEST_PARTS (REQUEST_ID, PART) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_REQUEST_PARTS ***
grant SELECT                                                                 on PFU_REQUEST_PARTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_REQUEST_PARTS.sql =========*** End 
PROMPT ===================================================================================== 
