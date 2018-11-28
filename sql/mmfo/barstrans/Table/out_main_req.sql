

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/OUT_MAIN_REQ.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table OUT_MAIN_REQ ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.OUT_MAIN_REQ 
   (	ID VARCHAR2(36), 
	SEND_TYPE VARCHAR2(50), 
	C_DATA CLOB, 
	B_DATA BLOB, 
	INS_DATE TIMESTAMP (6), 
	REQ_DATE CLOB, 
	STATUS NUMBER, 
	DONE_DATE TIMESTAMP (6),
    USER_ID NUMBER,
    USER_KF VARCHAR2(6 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (C_DATA) STORE AS SECUREFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  COMPRESS
  NOCACHE LOGGING ) 
 LOB (B_DATA) STORE AS SECUREFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION
  COMPRESS
  NOCACHE LOGGING ) 
 LOB (REQ_DATE) STORE AS SECUREFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION
  COMPRESS
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.OUT_MAIN_REQ IS 'Основні вихідні запити';
COMMENT ON COLUMN BARSTRANS.OUT_MAIN_REQ.ID IS 'Ід';
COMMENT ON COLUMN BARSTRANS.OUT_MAIN_REQ.SEND_TYPE IS 'Шаблон обробки зипиту';
COMMENT ON COLUMN BARSTRANS.OUT_MAIN_REQ.C_DATA IS 'Символьні дані';
COMMENT ON COLUMN BARSTRANS.OUT_MAIN_REQ.B_DATA IS 'Бінарні дані';
COMMENT ON COLUMN BARSTRANS.OUT_MAIN_REQ.INS_DATE IS 'Дата вставки';
COMMENT ON COLUMN BARSTRANS.OUT_MAIN_REQ.REQ_DATE IS 'Дата відправки запиту';
COMMENT ON COLUMN BARSTRANS.OUT_MAIN_REQ.STATUS IS 'Статус';
COMMENT ON COLUMN BARSTRANS.OUT_MAIN_REQ.DONE_DATE IS 'Дата завершення обробки';




PROMPT *** Create  constraint PK_OUT_MAIN_REQ ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_MAIN_REQ ADD CONSTRAINT PK_OUT_MAIN_REQ PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OUT_MAIN_REQ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_OUT_MAIN_REQ ON BARSTRANS.OUT_MAIN_REQ (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OUT_MAIN_REQ ***
grant SELECT                                                                 on OUT_MAIN_REQ    to BARS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/OUT_MAIN_REQ.sql =========*** End
PROMPT ===================================================================================== 

