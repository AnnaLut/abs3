

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/SYNC_ACTIVITY.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table SYNC_ACTIVITY ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.SYNC_ACTIVITY 
   (	TABLE_NAME VARCHAR2(30), 
	STATUS VARCHAR2(30), 
	STATUS_COMMENT VARCHAR2(4000), 
	START_TIME DATE, 
	FINISH_TIME DATE, 
	ERROR_NUMBER NUMBER, 
	ERROR_MESSAGE VARCHAR2(4000), 
	JOB_ID NUMBER, 
	SID NUMBER, 
	SERIAL# NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.SYNC_ACTIVITY IS 'Активность ручной синхронизации таблиц';
COMMENT ON COLUMN BARSAQ.SYNC_ACTIVITY.TABLE_NAME IS 'Имя таблицы';
COMMENT ON COLUMN BARSAQ.SYNC_ACTIVITY.STATUS IS 'Статус процесса синхронизации';
COMMENT ON COLUMN BARSAQ.SYNC_ACTIVITY.STATUS_COMMENT IS 'Комментарий к статусу';
COMMENT ON COLUMN BARSAQ.SYNC_ACTIVITY.START_TIME IS 'Время старта процесса';
COMMENT ON COLUMN BARSAQ.SYNC_ACTIVITY.FINISH_TIME IS 'Время завершения процесса';
COMMENT ON COLUMN BARSAQ.SYNC_ACTIVITY.ERROR_NUMBER IS 'Код ошибки';
COMMENT ON COLUMN BARSAQ.SYNC_ACTIVITY.ERROR_MESSAGE IS 'Сообщение об ошибке';
COMMENT ON COLUMN BARSAQ.SYNC_ACTIVITY.JOB_ID IS 'ID задания по синхронизации';
COMMENT ON COLUMN BARSAQ.SYNC_ACTIVITY.SID IS 'Идентификатор сессии';
COMMENT ON COLUMN BARSAQ.SYNC_ACTIVITY.SERIAL# IS 'Серийный номер сессии';




PROMPT *** Create  constraint CC_SYNCACTIVITY_STATUS_CC ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SYNC_ACTIVITY ADD CONSTRAINT CC_SYNCACTIVITY_STATUS_CC CHECK (status in (''ENQUEUED'',''STARTED'',''IN PROGRESS'',''SUCCEEDED'',''FAILED'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SYNCACTIVITY ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SYNC_ACTIVITY ADD CONSTRAINT PK_SYNCACTIVITY PRIMARY KEY (TABLE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SYNCACTIVITY_TABLENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SYNC_ACTIVITY MODIFY (TABLE_NAME CONSTRAINT CC_SYNCACTIVITY_TABLENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SYNCACTIVITY_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SYNC_ACTIVITY MODIFY (STATUS CONSTRAINT CC_SYNCACTIVITY_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SYNCACTIVITY_STARTTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SYNC_ACTIVITY MODIFY (START_TIME CONSTRAINT CC_SYNCACTIVITY_STARTTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SYNCACTIVITY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_SYNCACTIVITY ON BARSAQ.SYNC_ACTIVITY (TABLE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SYNC_ACTIVITY ***
grant SELECT                                                                 on SYNC_ACTIVITY   to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/SYNC_ACTIVITY.sql =========*** End *
PROMPT ===================================================================================== 
