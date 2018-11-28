

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/OUT_REQS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table OUT_REQS ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.OUT_REQS 
   (ID VARCHAR2(36), 
	MAIN_ID VARCHAR2(36), 
	REQ_ID VARCHAR2(50), 
	URI_GR_ID VARCHAR2(50), 
	URI_KF VARCHAR2(10), 
	TYPE_ID VARCHAR2(50), 
	INSERT_TIME TIMESTAMP (6), 
	SEND_TIME TIMESTAMP (6), 
	RESP_CLOB CLOB, 
	C_DATE CLOB, 
	B_DATE BLOB, 
	STATUS NUMBER, 
	PROCESSED_TIME TIMESTAMP (6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (RESP_CLOB) STORE AS SECUREFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION
  COMPRESS
  NOCACHE LOGGING ) 
 LOB (C_DATE) STORE AS SECUREFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  COMPRESS
  NOCACHE LOGGING ) 
 LOB (B_DATE) STORE AS SECUREFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  COMPRESS
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.OUT_REQS IS 'Вихідні підзапити';
COMMENT ON COLUMN BARSTRANS.OUT_REQS.ID IS 'Ід підзапиту';
COMMENT ON COLUMN BARSTRANS.OUT_REQS.MAIN_ID IS 'Ід запиту';
COMMENT ON COLUMN BARSTRANS.OUT_REQS.REQ_ID IS 'Ід запиту збоку адресата';
COMMENT ON COLUMN BARSTRANS.OUT_REQS.URI_GR_ID IS 'Група адресатів';
COMMENT ON COLUMN BARSTRANS.OUT_REQS.URI_KF IS 'Ід адресата';
COMMENT ON COLUMN BARSTRANS.OUT_REQS.TYPE_ID IS 'Назва типу запиту ';
COMMENT ON COLUMN BARSTRANS.OUT_REQS.INSERT_TIME IS 'Дата вставки';
COMMENT ON COLUMN BARSTRANS.OUT_REQS.SEND_TIME IS 'Дата доставки';
COMMENT ON COLUMN BARSTRANS.OUT_REQS.RESP_CLOB IS 'Дані з ВЕБ сервісе(очищується після конвертації відповіді)';
COMMENT ON COLUMN BARSTRANS.OUT_REQS.C_DATE IS 'Дані відповіді CLOB';
COMMENT ON COLUMN BARSTRANS.OUT_REQS.B_DATE IS 'Дані відповіді BLOB';
COMMENT ON COLUMN BARSTRANS.OUT_REQS.STATUS IS 'Статус';
COMMENT ON COLUMN BARSTRANS.OUT_REQS.PROCESSED_TIME IS 'Час опрацювання запиту';




PROMPT *** Create  constraint PK_OUT_REQS ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_REQS ADD CONSTRAINT PK_OUT_REQS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OUT_REQS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_OUT_REQS ON BARSTRANS.OUT_REQS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IND_OUT_REQS_MAIN_ID ***
begin   
 execute immediate '
  CREATE INDEX BARSTRANS.IND_OUT_REQS_MAIN_ID ON BARSTRANS.OUT_REQS (MAIN_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OUT_REQS ***
grant SELECT                                                                 on OUT_REQS        to BARS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/OUT_REQS.sql =========*** End ***
PROMPT ===================================================================================== 

