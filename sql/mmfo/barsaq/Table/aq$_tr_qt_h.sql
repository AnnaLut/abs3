

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/AQ$_TR_QT_H.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table AQ$_TR_QT_H ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.AQ$_TR_QT_H 
   (	MSGID RAW(16), 
	SUBSCRIBER# NUMBER, 
	NAME VARCHAR2(30), 
	ADDRESS# NUMBER, 
	DEQUEUE_TIME TIMESTAMP (6), 
	TRANSACTION_ID VARCHAR2(30), 
	DEQUEUE_USER VARCHAR2(30), 
	PROPAGATED_MSGID RAW(16), 
	RETRY_COUNT NUMBER, 
	HINT ROWID, 
	SPARE RAW(16), 
	 PRIMARY KEY (MSGID, SUBSCRIBER#, NAME, ADDRESS#) ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE AQTS 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.AQ$_TR_QT_H IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_H.MSGID IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_H.SUBSCRIBER# IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_H.NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_H.ADDRESS# IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_H.DEQUEUE_TIME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_H.TRANSACTION_ID IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_H.DEQUEUE_USER IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_H.PROPAGATED_MSGID IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_H.RETRY_COUNT IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_H.HINT IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_H.SPARE IS '';




PROMPT *** Create  constraint SYS_IOT_TOP_802698 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ$_TR_QT_H ADD PRIMARY KEY (MSGID, SUBSCRIBER#, NAME, ADDRESS#)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_IOT_TOP_802698 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.SYS_IOT_TOP_802698 ON BARSAQ.AQ$_TR_QT_H (MSGID, SUBSCRIBER#, NAME, ADDRESS#) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AQ$_TR_QT_H ***
grant SELECT                                                                 on AQ$_TR_QT_H     to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/AQ$_TR_QT_H.sql =========*** End ***
PROMPT ===================================================================================== 
