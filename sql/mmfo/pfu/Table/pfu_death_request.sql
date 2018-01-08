

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_DEATH_REQUEST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_DEATH_REQUEST ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_DEATH_REQUEST 
   (	ID NUMBER(10,0), 
	PFU_DEATH_ID NUMBER(10,0), 
	PFU_BRANCH_CODE VARCHAR2(300 CHAR), 
	PFU_BRANCH_NAME VARCHAR2(300 CHAR), 
	REGISTER_DATE DATE, 
	RECEIVER_MFO VARCHAR2(300 CHAR), 
	RECEIVER_BRANCH VARCHAR2(300 CHAR), 
	RECEIVER_NAME VARCHAR2(300 CHAR), 
	CHECK_SUM NUMBER(38,2), 
	CHECK_LINES_COUNT NUMBER(38,0), 
	CRT_DATE DATE DEFAULT sysdate, 
	FILES_DATA CLOB, 
	ECP_LIST CLOB, 
	DEATHLISTS CLOB, 
	STATE VARCHAR2(30), 
	ZIP_DATA BLOB, 
	USERID NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (FILES_DATA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (ECP_LIST) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (DEATHLISTS) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (ZIP_DATA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_DEATH_REQUEST IS 'Запит на отримання конверту з даними для зарахувань пенсій';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.ID IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.PFU_DEATH_ID IS 'Ідентифікатор конверту, отриманого в результаті виконання запиту на отримання конвертів';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.PFU_BRANCH_CODE IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.PFU_BRANCH_NAME IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.REGISTER_DATE IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.RECEIVER_MFO IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.RECEIVER_BRANCH IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.RECEIVER_NAME IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.CHECK_SUM IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.CHECK_LINES_COUNT IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.CRT_DATE IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.FILES_DATA IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.ECP_LIST IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.DEATHLISTS IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.STATE IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.ZIP_DATA IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_REQUEST.USERID IS '';




PROMPT *** Create  constraint FK_DEATH_REQ_REF_REQUEST ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_DEATH_REQUEST ADD CONSTRAINT FK_DEATH_REQ_REF_REQUEST FOREIGN KEY (ID)
	  REFERENCES PFU.PFU_REQUEST (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_DEATH_REQUEST ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_DEATH_REQUEST ADD CONSTRAINT PK_PFU_DEATH_REQUEST PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111527 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_DEATH_REQUEST MODIFY (PFU_DEATH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111526 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_DEATH_REQUEST MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_DEATH_REQUEST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_DEATH_REQUEST ON PFU.PFU_DEATH_REQUEST (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_DEATH_REQUEST ***
grant SELECT                                                                 on PFU_DEATH_REQUEST to BARS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_DEATH_REQUEST.sql =========*** End 
PROMPT ===================================================================================== 
