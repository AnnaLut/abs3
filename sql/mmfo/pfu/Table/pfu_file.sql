

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_FILE.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_FILE ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_FILE 
   (	ID NUMBER(10,0), 
	ENVELOPE_REQUEST_ID NUMBER(10,0), 
	CHECK_SUM NUMBER(38,2), 
	CHECK_LINES_COUNT NUMBER(38,0), 
	PAYMENT_DATE DATE, 
	FILE_NUMBER NUMBER(5,0), 
	FILE_NAME VARCHAR2(256 CHAR), 
	FILE_DATA BLOB, 
	STATE VARCHAR2(20), 
	CRT_DATE DATE, 
	DATA_SIGN CLOB, 
	USERID NUMBER(38,0), 
	PAY_DATE DATE, 
	MATCH_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (FILE_DATA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (DATA_SIGN) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_FILE IS '';
COMMENT ON COLUMN PFU.PFU_FILE.ID IS '';
COMMENT ON COLUMN PFU.PFU_FILE.ENVELOPE_REQUEST_ID IS '';
COMMENT ON COLUMN PFU.PFU_FILE.CHECK_SUM IS '';
COMMENT ON COLUMN PFU.PFU_FILE.CHECK_LINES_COUNT IS '';
COMMENT ON COLUMN PFU.PFU_FILE.PAYMENT_DATE IS '';
COMMENT ON COLUMN PFU.PFU_FILE.FILE_NUMBER IS 'Порядковий номер файлу в конверті';
COMMENT ON COLUMN PFU.PFU_FILE.FILE_NAME IS '';
COMMENT ON COLUMN PFU.PFU_FILE.FILE_DATA IS '';
COMMENT ON COLUMN PFU.PFU_FILE.STATE IS '';
COMMENT ON COLUMN PFU.PFU_FILE.CRT_DATE IS '';
COMMENT ON COLUMN PFU.PFU_FILE.DATA_SIGN IS '';
COMMENT ON COLUMN PFU.PFU_FILE.USERID IS '';
COMMENT ON COLUMN PFU.PFU_FILE.PAY_DATE IS '';
COMMENT ON COLUMN PFU.PFU_FILE.MATCH_DATE IS '';




PROMPT *** Create  constraint PK_PFU_FILE ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_FILE ADD CONSTRAINT PK_PFU_FILE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111539 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_FILE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PFU_FILE_STATE ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_FILE ADD CONSTRAINT FK_PFU_FILE_STATE FOREIGN KEY (STATE)
	  REFERENCES PFU.PFU_FILE_STATE (STATE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PFU_FILE_REF_PFU_ENVELOP ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_FILE ADD CONSTRAINT FK_PFU_FILE_REF_PFU_ENVELOP FOREIGN KEY (ENVELOPE_REQUEST_ID)
	  REFERENCES PFU.PFU_ENVELOPE_REQUEST (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_FILE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_FILE ON PFU.PFU_FILE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_FILE ***
grant SELECT                                                                 on PFU_FILE        to BARS;
grant SELECT                                                                 on PFU_FILE        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_FILE.sql =========*** End *** =====
PROMPT ===================================================================================== 
