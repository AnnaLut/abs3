

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/AQ$_STREAMS_QUEUE_TABLE_D.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  table AQ$_STREAMS_QUEUE_TABLE_D ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.AQ$_STREAMS_QUEUE_TABLE_D 
   (	QID NUMBER, 
	MSGNUM NUMBER, 
	MSGID RAW(16), 
	SUB NUMBER, 
	SEQNUM NUMBER, 
	RSUBS SYS.AQ$_RECIPIENTS , 
	 PRIMARY KEY (QID, MSGNUM, SUB) ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE AQTS 
 PCTTHRESHOLD 50 OVERFLOW
 PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 LOGGING
  TABLESPACE AQTS 
 VARRAY RSUBS STORE AS BASICFILE LOB 
  (ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  CACHE ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.AQ$_STREAMS_QUEUE_TABLE_D IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_D.QID IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_D.MSGNUM IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_D.MSGID IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_D.SUB IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_D.SEQNUM IS '';
COMMENT ON COLUMN BARSAQ.AQ$_STREAMS_QUEUE_TABLE_D.RSUBS IS '';




PROMPT *** Create  constraint SYS_IOT_TOP_80064 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ$_STREAMS_QUEUE_TABLE_D ADD PRIMARY KEY (QID, MSGNUM, SUB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_IOT_TOP_80064 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.SYS_IOT_TOP_80064 ON BARSAQ.AQ$_STREAMS_QUEUE_TABLE_D (QID, MSGNUM, SUB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AQ$_STREAMS_QUEUE_TABLE_D ***
grant SELECT                                                                 on AQ$_STREAMS_QUEUE_TABLE_D to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/AQ$_STREAMS_QUEUE_TABLE_D.sql ======
PROMPT ===================================================================================== 
