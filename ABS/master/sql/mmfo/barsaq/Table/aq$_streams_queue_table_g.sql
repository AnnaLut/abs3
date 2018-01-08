

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/AQ$_STREAMS_QUEUE_TABLE_G.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  table AQ$_STREAMS_QUEUE_TABLE_G ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.AQ$_STREAMS_QUEUE_TABLE_G 
   (	MSGID RAW(16), 
	SUBSCRIBER# NUMBER, 
	NAME VARCHAR2(30), 
	ADDRESS# NUMBER, 
	SIGN SYS.AQ$_SIG_PROP , 
	DBS_SIGN SYS.AQ$_SIG_PROP , 
	 PRIMARY KEY (MSGID, SUBSCRIBER#, NAME, ADDRESS#) ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE AQTS 
 PCTTHRESHOLD 50 INCLUDING SIGN OVERFLOW
 PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 LOGGING
  TABLESPACE AQTS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.AQ$_STREAMS_QUEUE_TABLE_G IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_G.MSGID IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_G.SUBSCRIBER# IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_G.NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_G.ADDRESS# IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_G.SIGN IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_G.DBS_SIGN IS '';




PROMPT *** Create  constraint SYS_IOT_TOP_79961 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ$_STREAMS_QUEUE_TABLE_G ADD PRIMARY KEY (MSGID, SUBSCRIBER#, NAME, ADDRESS#)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_IOT_TOP_79961 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.SYS_IOT_TOP_79961 ON BARSAQ.AQ$_STREAMS_QUEUE_TABLE_G (MSGID, SUBSCRIBER#, NAME, ADDRESS#) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AQ$_STREAMS_QUEUE_TABLE_G ***
grant SELECT                                                                 on AQ$_STREAMS_QUEUE_TABLE_G to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/AQ$_STREAMS_QUEUE_TABLE_G.sql ======
PROMPT ===================================================================================== 
