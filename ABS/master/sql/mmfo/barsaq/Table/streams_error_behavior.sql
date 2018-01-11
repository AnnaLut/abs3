

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/STREAMS_ERROR_BEHAVIOR.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  table STREAMS_ERROR_BEHAVIOR ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.STREAMS_ERROR_BEHAVIOR 
   (	STREAM_TYPE VARCHAR2(30), 
	ERROR_NUMBER NUMBER, 
	ERROR_MESSAGE VARCHAR2(4000), 
	USER_ERROR_NUMBER NUMBER, 
	USER_ERROR_MESSAGE VARCHAR2(4000), 
	ACTION VARCHAR2(30) DEFAULT ''NONE'', 
	RETRY_COUNT NUMBER(*,0) DEFAULT 1, 
	RETRY_INTERVAL VARCHAR2(256), 
	ENABLED_PERIOD NUMBER(*,0) DEFAULT 30
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.STREAMS_ERROR_BEHAVIOR IS 'Поведение потоков при ошибках';
COMMENT ON COLUMN BARSAQ.STREAMS_ERROR_BEHAVIOR.STREAM_TYPE IS 'Тип потока: CAPTURE, APPLY, PROPAGATION';
COMMENT ON COLUMN BARSAQ.STREAMS_ERROR_BEHAVIOR.ERROR_NUMBER IS 'Код ошибки';
COMMENT ON COLUMN BARSAQ.STREAMS_ERROR_BEHAVIOR.ERROR_MESSAGE IS 'Описание ошибки';
COMMENT ON COLUMN BARSAQ.STREAMS_ERROR_BEHAVIOR.USER_ERROR_NUMBER IS 'Код пользовательской ошибки';
COMMENT ON COLUMN BARSAQ.STREAMS_ERROR_BEHAVIOR.USER_ERROR_MESSAGE IS 'Описание пользовательской ошибки';
COMMENT ON COLUMN BARSAQ.STREAMS_ERROR_BEHAVIOR.ACTION IS 'Действие: NONE,START,EXEC_START,DEL_START';
COMMENT ON COLUMN BARSAQ.STREAMS_ERROR_BEHAVIOR.RETRY_COUNT IS 'Кол-во попыток восстановления';
COMMENT ON COLUMN BARSAQ.STREAMS_ERROR_BEHAVIOR.RETRY_INTERVAL IS 'Формула интервала в минутах между попытками восстановления по таблице streams_statuses';
COMMENT ON COLUMN BARSAQ.STREAMS_ERROR_BEHAVIOR.ENABLED_PERIOD IS 'Период в минутах работы потока в статусе ENABLED';




PROMPT *** Create  constraint CC_STREAMSERRORBHR_STRMT_CC ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_ERROR_BEHAVIOR ADD CONSTRAINT CC_STREAMSERRORBHR_STRMT_CC CHECK (stream_type in (''CAPTURE'',''APPLY'',''PROPAGATION'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREAMSERRORBHR_ACT_CC ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_ERROR_BEHAVIOR ADD CONSTRAINT CC_STREAMSERRORBHR_ACT_CC CHECK (action in (''NONE'',''START'',''EXEC_START'',''DEL_START'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STREAMSERRORBHR ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_ERROR_BEHAVIOR ADD CONSTRAINT PK_STREAMSERRORBHR PRIMARY KEY (STREAM_TYPE, ERROR_NUMBER, USER_ERROR_NUMBER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREAMSERRORBHR_STRMT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_ERROR_BEHAVIOR MODIFY (STREAM_TYPE CONSTRAINT CC_STREAMSERRORBHR_STRMT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREAMSERRORBHR_ERRNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_ERROR_BEHAVIOR MODIFY (ERROR_NUMBER CONSTRAINT CC_STREAMSERRORBHR_ERRNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREAMSERRORBHR_UERRNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_ERROR_BEHAVIOR MODIFY (USER_ERROR_NUMBER CONSTRAINT CC_STREAMSERRORBHR_UERRNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREAMSERRORBHR_ACT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_ERROR_BEHAVIOR MODIFY (ACTION CONSTRAINT CC_STREAMSERRORBHR_ACT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREAMSERRORBHR_RETRYCNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_ERROR_BEHAVIOR MODIFY (RETRY_COUNT CONSTRAINT CC_STREAMSERRORBHR_RETRYCNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREAMSERRORBHR_RETRYINT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_ERROR_BEHAVIOR MODIFY (RETRY_INTERVAL CONSTRAINT CC_STREAMSERRORBHR_RETRYINT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREAMSERRORBHR_ENP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_ERROR_BEHAVIOR MODIFY (ENABLED_PERIOD CONSTRAINT CC_STREAMSERRORBHR_ENP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STREAMSERRORBHR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_STREAMSERRORBHR ON BARSAQ.STREAMS_ERROR_BEHAVIOR (STREAM_TYPE, ERROR_NUMBER, USER_ERROR_NUMBER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STREAMS_ERROR_BEHAVIOR ***
grant SELECT                                                                 on STREAMS_ERROR_BEHAVIOR to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/STREAMS_ERROR_BEHAVIOR.sql =========
PROMPT ===================================================================================== 
