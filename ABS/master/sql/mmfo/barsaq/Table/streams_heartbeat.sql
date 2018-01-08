

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/STREAMS_HEARTBEAT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table STREAMS_HEARTBEAT ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.STREAMS_HEARTBEAT 
   (	GLOBAL_NAME VARCHAR2(128), 
	HEARTBEAT_TIME DATE DEFAULT sysdate, 
	 CONSTRAINT PK_STREAMSHB PRIMARY KEY (GLOBAL_NAME) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.STREAMS_HEARTBEAT IS 'Сердцебиение потоков синхронизации Oracle Streams';
COMMENT ON COLUMN BARSAQ.STREAMS_HEARTBEAT.GLOBAL_NAME IS 'Глобальное имя базы данных';
COMMENT ON COLUMN BARSAQ.STREAMS_HEARTBEAT.HEARTBEAT_TIME IS 'Временная метка сердцебиения';




PROMPT *** Create  constraint CC_STREAMSHB_HBTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_HEARTBEAT MODIFY (HEARTBEAT_TIME CONSTRAINT CC_STREAMSHB_HBTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREAMSHB_GLOBALNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_HEARTBEAT MODIFY (GLOBAL_NAME CONSTRAINT CC_STREAMSHB_GLOBALNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STREAMSHB ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.STREAMS_HEARTBEAT ADD CONSTRAINT PK_STREAMSHB PRIMARY KEY (GLOBAL_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STREAMSHB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_STREAMSHB ON BARSAQ.STREAMS_HEARTBEAT (GLOBAL_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/STREAMS_HEARTBEAT.sql =========*** E
PROMPT ===================================================================================== 
