

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/STREAMS_STATUSES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  table STREAMS_STATUSES ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.STREAMS_STATUSES 
   (	SCAN_TIME DATE DEFAULT sysdate, 
	STREAMS_NAME VARCHAR2(30), 
	STATUS VARCHAR2(30), 
	STATUS_CHANGE_TIME DATE, 
	LAST_ENABLED_TIME DATE, 
	ERROR_NUMBER NUMBER, 
	ERROR_MESSAGE VARCHAR2(4000), 
	ERROR_TIME DATE, 
	USER_ERROR_NUMBER NUMBER, 
	USER_ERROR_MESSAGE VARCHAR2(4000), 
	RETRY_NUM NUMBER(*,0) DEFAULT 0, 
	RETRY_TIME DATE, 
	MONITOR_ERROR_NUMBER NUMBER, 
	MONITOR_ERROR_MESSAGE VARCHAR2(4000), 
	MONITOR_ERROR_TIME DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.STREAMS_STATUSES IS 'Статусы потоков синхронизации';
COMMENT ON COLUMN BARSAQ.STREAMS_STATUSES.SCAN_TIME IS '';
COMMENT ON COLUMN BARSAQ.STREAMS_STATUSES.STREAMS_NAME IS 'Имя потока';
COMMENT ON COLUMN BARSAQ.STREAMS_STATUSES.STATUS IS 'Статус';
COMMENT ON COLUMN BARSAQ.STREAMS_STATUSES.STATUS_CHANGE_TIME IS 'Время изменения статуса';
COMMENT ON COLUMN BARSAQ.STREAMS_STATUSES.LAST_ENABLED_TIME IS 'Время последнего изменения статуса на ENABLED';
COMMENT ON COLUMN BARSAQ.STREAMS_STATUSES.ERROR_NUMBER IS 'Номер последней ошибки';
COMMENT ON COLUMN BARSAQ.STREAMS_STATUSES.ERROR_MESSAGE IS 'Текст последней ошибки';
COMMENT ON COLUMN BARSAQ.STREAMS_STATUSES.ERROR_TIME IS 'Время возникновения последней ошибки';
COMMENT ON COLUMN BARSAQ.STREAMS_STATUSES.USER_ERROR_NUMBER IS 'Номер первой пользовательской ошибки';
COMMENT ON COLUMN BARSAQ.STREAMS_STATUSES.USER_ERROR_MESSAGE IS 'Текст первой пользовательской ошибки';
COMMENT ON COLUMN BARSAQ.STREAMS_STATUSES.RETRY_NUM IS 'Номер итерации по исправлению ошибок';
COMMENT ON COLUMN BARSAQ.STREAMS_STATUSES.RETRY_TIME IS 'Время последнего исправления ошибок';
COMMENT ON COLUMN BARSAQ.STREAMS_STATUSES.MONITOR_ERROR_NUMBER IS 'Номер ошибки монитора при исправлении ошибок потока';
COMMENT ON COLUMN BARSAQ.STREAMS_STATUSES.MONITOR_ERROR_MESSAGE IS 'Описание ошибки монитора при исправлении ошибок потока';
COMMENT ON COLUMN BARSAQ.STREAMS_STATUSES.MONITOR_ERROR_TIME IS 'Время возникновения ошибки монитора при исправлении ошибок потока';




PROMPT *** Create  constraint PK_STREAMSSTATUSES ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_STATUSES ADD CONSTRAINT PK_STREAMSSTATUSES PRIMARY KEY (STREAMS_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREAMSSTATUSES_SCANT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_STATUSES MODIFY (SCAN_TIME CONSTRAINT CC_STREAMSSTATUSES_SCANT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREAMSSTATUSES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_STATUSES MODIFY (STREAMS_NAME CONSTRAINT CC_STREAMSSTATUSES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREAMSSTATUSES_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_STATUSES MODIFY (STATUS CONSTRAINT CC_STREAMSSTATUSES_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREAMSSTATUSES_STATCHT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_STATUSES MODIFY (STATUS_CHANGE_TIME CONSTRAINT CC_STREAMSSTATUSES_STATCHT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREAMSSTATUSES_RETRYNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_STATUSES MODIFY (RETRY_NUM CONSTRAINT CC_STREAMSSTATUSES_RETRYNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STREAMSSTATUSES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_STREAMSSTATUSES ON BARSAQ.STREAMS_STATUSES (STREAMS_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/STREAMS_STATUSES.sql =========*** En
PROMPT ===================================================================================== 
