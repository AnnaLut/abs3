

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/INPUT_QUEUE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table INPUT_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.INPUT_QUEUE 
   (REQ_ID VARCHAR2(36), 
	IS_MAIN NUMBER(1,0), 
	PRIORITY NUMBER(2,0), 
	STATUS NUMBER(2,0), 
	INSERT_TIME TIMESTAMP (6), 
	EXEC_TRY NUMBER, 
	LAST_TRY TIMESTAMP (6)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.INPUT_QUEUE IS 'Черга обробки вхідних запитів';
COMMENT ON COLUMN BARSTRANS.INPUT_QUEUE.REQ_ID IS 'Ід запиту';
COMMENT ON COLUMN BARSTRANS.INPUT_QUEUE.IS_MAIN IS 'Признак основного запиту';
COMMENT ON COLUMN BARSTRANS.INPUT_QUEUE.PRIORITY IS 'Пріорітет';
COMMENT ON COLUMN BARSTRANS.INPUT_QUEUE.STATUS IS 'Статус';
COMMENT ON COLUMN BARSTRANS.INPUT_QUEUE.INSERT_TIME IS 'Дата вставки';
COMMENT ON COLUMN BARSTRANS.INPUT_QUEUE.EXEC_TRY IS 'Кількість спроб відправки';
COMMENT ON COLUMN BARSTRANS.INPUT_QUEUE.LAST_TRY IS 'Час останьої спроби';




PROMPT *** Create  constraint PK_INPUT_QUEUE ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_QUEUE ADD CONSTRAINT PK_INPUT_QUEUE PRIMARY KEY (REQ_ID, PRIORITY)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INPUT_QUEUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_INPUT_QUEUE ON BARSTRANS.INPUT_QUEUE (REQ_ID, PRIORITY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/INPUT_QUEUE.sql =========*** End 
PROMPT ===================================================================================== 

