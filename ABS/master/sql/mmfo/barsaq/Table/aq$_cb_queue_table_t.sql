

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/AQ$_CB_QUEUE_TABLE_T.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  table AQ$_CB_QUEUE_TABLE_T ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.AQ$_CB_QUEUE_TABLE_T 
   (	NEXT_DATE TIMESTAMP (6), 
	TXN_ID VARCHAR2(30), 
	MSGID RAW(16), 
	ACTION NUMBER, 
	 PRIMARY KEY (NEXT_DATE, TXN_ID, MSGID) ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE AQTS 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.AQ$_CB_QUEUE_TABLE_T IS '';
COMMENT ON COLUMN BARSAQ.AQ$_CB_QUEUE_TABLE_T.NEXT_DATE IS '';
COMMENT ON COLUMN BARSAQ.AQ$_CB_QUEUE_TABLE_T.TXN_ID IS '';
COMMENT ON COLUMN BARSAQ.AQ$_CB_QUEUE_TABLE_T.MSGID IS '';
COMMENT ON COLUMN BARSAQ.AQ$_CB_QUEUE_TABLE_T.ACTION IS '';




PROMPT *** Create  constraint SYS_IOT_TOP_756842 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ$_CB_QUEUE_TABLE_T ADD PRIMARY KEY (NEXT_DATE, TXN_ID, MSGID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_IOT_TOP_756842 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.SYS_IOT_TOP_756842 ON BARSAQ.AQ$_CB_QUEUE_TABLE_T (NEXT_DATE, TXN_ID, MSGID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/AQ$_CB_QUEUE_TABLE_T.sql =========**
PROMPT ===================================================================================== 
