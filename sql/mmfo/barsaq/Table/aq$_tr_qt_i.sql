

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/AQ$_TR_QT_I.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table AQ$_TR_QT_I ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.AQ$_TR_QT_I 
   (	SUBSCRIBER# NUMBER, 
	NAME VARCHAR2(30), 
	QUEUE# NUMBER, 
	MSG_ENQ_TID VARCHAR2(30), 
	SENDER# NUMBER, 
	TXN_STEP# NUMBER, 
	MSG_CHAIN_NO NUMBER, 
	MSG_LOCAL_ORDER_NO NUMBER, 
	MSGID RAW(16), 
	HINT ROWID, 
	SPARE RAW(16), 
	 PRIMARY KEY (SUBSCRIBER#, NAME, QUEUE#, MSG_ENQ_TID, SENDER#, TXN_STEP#, MSG_CHAIN_NO, MSG_LOCAL_ORDER_NO, MSGID) ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE AQTS 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.AQ$_TR_QT_I IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_I.SUBSCRIBER# IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_I.NAME IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_I.QUEUE# IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_I.MSG_ENQ_TID IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_I.SENDER# IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_I.TXN_STEP# IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_I.MSG_CHAIN_NO IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_I.MSG_LOCAL_ORDER_NO IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_I.MSGID IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_I.HINT IS '';
COMMENT ON COLUMN BARSAQ.AQ$_TR_QT_I.SPARE IS '';




PROMPT *** Create  constraint SYS_IOT_TOP_802704 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ$_TR_QT_I ADD PRIMARY KEY (SUBSCRIBER#, NAME, QUEUE#, MSG_ENQ_TID, SENDER#, TXN_STEP#, MSG_CHAIN_NO, MSG_LOCAL_ORDER_NO, MSGID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_IOT_TOP_802704 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.SYS_IOT_TOP_802704 ON BARSAQ.AQ$_TR_QT_I (SUBSCRIBER#, NAME, QUEUE#, MSG_ENQ_TID, SENDER#, TXN_STEP#, MSG_CHAIN_NO, MSG_LOCAL_ORDER_NO, MSGID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/AQ$_TR_QT_I.sql =========*** End ***
PROMPT ===================================================================================== 
