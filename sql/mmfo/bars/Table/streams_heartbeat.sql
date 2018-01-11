

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STREAMS_HEARTBEAT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STREAMS_HEARTBEAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STREAMS_HEARTBEAT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STREAMS_HEARTBEAT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STREAMS_HEARTBEAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STREAMS_HEARTBEAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.STREAMS_HEARTBEAT 
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




PROMPT *** ALTER_POLICIES to STREAMS_HEARTBEAT ***
 exec bpa.alter_policies('STREAMS_HEARTBEAT');


COMMENT ON TABLE BARS.STREAMS_HEARTBEAT IS 'Сердцебиение потоков синхронизации Oracle Streams';
COMMENT ON COLUMN BARS.STREAMS_HEARTBEAT.GLOBAL_NAME IS 'Глобальное имя базы данных';
COMMENT ON COLUMN BARS.STREAMS_HEARTBEAT.HEARTBEAT_TIME IS 'Временная метка сердцебиения';




PROMPT *** Create  constraint CC_STREAMSHB_GLOBALNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STREAMS_HEARTBEAT MODIFY (GLOBAL_NAME CONSTRAINT CC_STREAMSHB_GLOBALNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STREAMSHB_HBTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STREAMS_HEARTBEAT MODIFY (HEARTBEAT_TIME CONSTRAINT CC_STREAMSHB_HBTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STREAMSHB ***
begin   
 execute immediate '
  ALTER TABLE BARS.STREAMS_HEARTBEAT ADD CONSTRAINT PK_STREAMSHB PRIMARY KEY (GLOBAL_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STREAMSHB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STREAMSHB ON BARS.STREAMS_HEARTBEAT (GLOBAL_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STREAMS_HEARTBEAT ***
grant FLASHBACK,SELECT                                                       on STREAMS_HEARTBEAT to BARSAQ;
grant SELECT                                                                 on STREAMS_HEARTBEAT to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STREAMS_HEARTBEAT.sql =========*** End
PROMPT ===================================================================================== 
