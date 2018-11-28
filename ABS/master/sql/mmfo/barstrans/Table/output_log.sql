

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/OUTPUT_LOG.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table OUTPUT_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.OUTPUT_LOG
   (ID NUMBER, 
	REQ_ID VARCHAR2(36), 
	SUB_REQ VARCHAR2(36), 
	CHK_REQ VARCHAR2(36), 
	ACT VARCHAR2(255), 
	STATE VARCHAR2(255), 
	MESSAGE VARCHAR2(4000), 
	BIG_MESSAGE CLOB, 
	INSERT_DATE TIMESTAMP (6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (BIG_MESSAGE) STORE AS SECUREFILE(
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  COMPRESS
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.OUTPUT_LOG IS 'Журнал вихідних запитів';
COMMENT ON COLUMN BARSTRANS.OUTPUT_LOG.ID IS 'ІД';
COMMENT ON COLUMN BARSTRANS.OUTPUT_LOG.REQ_ID IS 'ІД запиту';
COMMENT ON COLUMN BARSTRANS.OUTPUT_LOG.SUB_REQ IS 'Ід підзапиту';
COMMENT ON COLUMN BARSTRANS.OUTPUT_LOG.CHK_REQ IS 'Ід запиту перевірки виконання';
COMMENT ON COLUMN BARSTRANS.OUTPUT_LOG.ACT IS 'Дія Яка логується';
COMMENT ON COLUMN BARSTRANS.OUTPUT_LOG.STATE IS 'Статус';
COMMENT ON COLUMN BARSTRANS.OUTPUT_LOG.MESSAGE IS 'Повідомлення';
COMMENT ON COLUMN BARSTRANS.OUTPUT_LOG.BIG_MESSAGE IS 'Повідомлення CLOB';
COMMENT ON COLUMN BARSTRANS.OUTPUT_LOG.INSERT_DATE IS 'Дата вставки';



PROMPT *** Create  constraint PK_OUTPUT_LOG ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUTPUT_LOG ADD CONSTRAINT PK_OUTPUT_LOG PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OUTPUT_LOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_OUTPUT_LOG ON BARSTRANS.OUTPUT_LOG (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IND_OUTPUT_LOG_D_ID ***
begin   
 execute immediate '
  CREATE INDEX BARSTRANS.IND_OUTPUT_LOG_D_ID ON BARSTRANS.OUTPUT_LOG (REQ_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/OUTPUT_LOG.sql =========*** End *
PROMPT ===================================================================================== 

