

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/INPUT_LOG.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table INPUT_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.INPUT_LOG 
   (ID NUMBER, 
	REQ_ID VARCHAR2(36), 
	ACT VARCHAR2(255), 
	STATE VARCHAR2(255), 
	MESSAGE VARCHAR2(4000), 
	BIG_MESSAGE CLOB, 
	INSERT_DATE TIMESTAMP (6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (BIG_MESSAGE) STORE AS SECUREFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  COMPRESS
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.INPUT_LOG IS 'Лог вхідних запитів';
COMMENT ON COLUMN BARSTRANS.INPUT_LOG.ID IS 'Ід запису в лог';
COMMENT ON COLUMN BARSTRANS.INPUT_LOG.REQ_ID IS 'Ід запиту';
COMMENT ON COLUMN BARSTRANS.INPUT_LOG.ACT IS 'Тип події';
COMMENT ON COLUMN BARSTRANS.INPUT_LOG.STATE IS 'Стан (err,info etc.)';
COMMENT ON COLUMN BARSTRANS.INPUT_LOG.MESSAGE IS 'Повідомлення';
COMMENT ON COLUMN BARSTRANS.INPUT_LOG.BIG_MESSAGE IS 'Повідомлення CLOB';
COMMENT ON COLUMN BARSTRANS.INPUT_LOG.INSERT_DATE IS 'Дата вставки';




PROMPT *** Create  constraint PK_INPUT_LOG ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_LOG ADD CONSTRAINT PK_INPUT_LOG PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INPUT_LOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_INPUT_LOG ON BARSTRANS.INPUT_LOG (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/INPUT_LOG.sql =========*** End **
PROMPT ===================================================================================== 

