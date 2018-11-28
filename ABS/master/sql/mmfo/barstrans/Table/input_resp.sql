

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/INPUT_RESP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table INPUT_RESP ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.INPUT_RESP 
   (REQ_ID VARCHAR2(36), 
	D_CLOB CLOB, 
	D_BLOB BLOB, 
	INSERT_TIME TIMESTAMP (6), 
	RESP_CLOB CLOB, 
	CONVERT_TIME TIMESTAMP (6), 
	SEND_TIME TIMESTAMP (6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (D_CLOB) STORE AS SECUREFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION
  COMPRESS
  NOCACHE LOGGING ) 
 LOB (D_BLOB) STORE AS SECUREFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION
  COMPRESS
  NOCACHE LOGGING ) 
 LOB (RESP_CLOB) STORE AS SECUREFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION
  COMPRESS
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.INPUT_RESP IS 'Відповіді на запити';
COMMENT ON COLUMN BARSTRANS.INPUT_RESP.REQ_ID IS 'Ід запиту';
COMMENT ON COLUMN BARSTRANS.INPUT_RESP.D_CLOB IS 'Символьна відповідь';
COMMENT ON COLUMN BARSTRANS.INPUT_RESP.D_BLOB IS 'Бінарна відповідь';
COMMENT ON COLUMN BARSTRANS.INPUT_RESP.INSERT_TIME IS 'Дата вставки';
COMMENT ON COLUMN BARSTRANS.INPUT_RESP.RESP_CLOB IS 'Дані для сервісу';
COMMENT ON COLUMN BARSTRANS.INPUT_RESP.CONVERT_TIME IS 'Дата перетворення';
COMMENT ON COLUMN BARSTRANS.INPUT_RESP.SEND_TIME IS 'Дата відправки';




PROMPT *** Create  constraint PK_INPUT_RESP ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_RESP ADD CONSTRAINT PK_INPUT_RESP PRIMARY KEY (REQ_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INPUT_RESP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_INPUT_RESP ON BARSTRANS.INPUT_RESP (REQ_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/INPUT_RESP.sql =========*** End *
PROMPT ===================================================================================== 

