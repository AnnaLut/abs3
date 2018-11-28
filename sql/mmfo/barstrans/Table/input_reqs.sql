

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/INPUT_REQS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table INPUT_REQS ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.INPUT_REQS 
   (ID VARCHAR2(36), 
	HTTP_TYPE VARCHAR2(36), 
	TYPE_NAME VARCHAR2(50), 
	REQ_ACTION VARCHAR2(50), 
	REQ_USER VARCHAR2(50), 
	REQ_DATE CLOB, 
	INSERT_TIME TIMESTAMP (6), 
	D_CLOB CLOB, 
	D_BLOB BLOB, 
	CONVERT_TIME TIMESTAMP (6), 
	STATUS NUMBER, 
	PROCESSED_TIME TIMESTAMP (6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (REQ_DATE) STORE AS SECUREFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION
  COMPRESS 
  NOCACHE LOGGING ) 
 LOB (D_CLOB) STORE AS SECUREFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION
  COMPRESS
  NOCACHE LOGGING ) 
 LOB (D_BLOB) STORE AS SECUREFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION
  COMPRESS
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.INPUT_REQS IS 'Вхідні запити';
COMMENT ON COLUMN BARSTRANS.INPUT_REQS.ID IS 'Ід запиту';
COMMENT ON COLUMN BARSTRANS.INPUT_REQS.HTTP_TYPE IS 'Тип запиту HTTP(POST, GET)';
COMMENT ON COLUMN BARSTRANS.INPUT_REQS.TYPE_NAME IS 'Тип запиту';
COMMENT ON COLUMN BARSTRANS.INPUT_REQS.REQ_ACTION IS 'Назва дії при обробці';
COMMENT ON COLUMN BARSTRANS.INPUT_REQS.REQ_USER IS 'Користувач, яким авторизувався сервіс';
COMMENT ON COLUMN BARSTRANS.INPUT_REQS.REQ_DATE IS 'Дані, які прийняв сервіс';
COMMENT ON COLUMN BARSTRANS.INPUT_REQS.INSERT_TIME IS 'Дата прийняття даних';
COMMENT ON COLUMN BARSTRANS.INPUT_REQS.D_CLOB IS 'Конвіртовані символьні дані';
COMMENT ON COLUMN BARSTRANS.INPUT_REQS.D_BLOB IS 'Конвіртовані бінарнві дані';
COMMENT ON COLUMN BARSTRANS.INPUT_REQS.CONVERT_TIME IS 'Дата конвертації';
COMMENT ON COLUMN BARSTRANS.INPUT_REQS.STATUS IS 'Статус';
COMMENT ON COLUMN BARSTRANS.INPUT_REQS.PROCESSED_TIME IS 'Дата закінчення обробки';




PROMPT *** Create  constraint PK_INPUT_REQS ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_REQS ADD CONSTRAINT PK_INPUT_REQS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INPUT_REQS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_INPUT_REQS ON BARSTRANS.INPUT_REQS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INPUT_REQS ***
grant INSERT,UPDATE                                                          on INPUT_REQS      to BARS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/INPUT_REQS.sql =========*** End *
PROMPT ===================================================================================== 

