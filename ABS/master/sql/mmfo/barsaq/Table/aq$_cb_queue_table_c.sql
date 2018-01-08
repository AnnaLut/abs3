

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/AQ$_CB_QUEUE_TABLE_C.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  table AQ$_CB_QUEUE_TABLE_C ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.AQ$_CB_QUEUE_TABLE_C 
   (	CSCN NUMBER, 
	ENQ_TID VARCHAR2(30), 
	MSGCNT NUMBER, 
	 PRIMARY KEY (CSCN, ENQ_TID) ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE AQTS 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.AQ$_CB_QUEUE_TABLE_C IS '';
COMMENT ON COLUMN BARSAQ.AQ$_CB_QUEUE_TABLE_C.CSCN IS '';
COMMENT ON COLUMN BARSAQ.AQ$_CB_QUEUE_TABLE_C.ENQ_TID IS '';
COMMENT ON COLUMN BARSAQ.AQ$_CB_QUEUE_TABLE_C.MSGCNT IS '';




PROMPT *** Create  constraint SYS_IOT_TOP_756852 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.AQ$_CB_QUEUE_TABLE_C ADD PRIMARY KEY (CSCN, ENQ_TID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_IOT_TOP_756852 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.SYS_IOT_TOP_756852 ON BARSAQ.AQ$_CB_QUEUE_TABLE_C (CSCN, ENQ_TID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index AQ$_CB_QUEUE_TABLE_Y ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.AQ$_CB_QUEUE_TABLE_Y ON BARSAQ.AQ$_CB_QUEUE_TABLE_C (ENQ_TID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AQ$_CB_QUEUE_TABLE_C ***
grant SELECT                                                                 on AQ$_CB_QUEUE_TABLE_C to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/AQ$_CB_QUEUE_TABLE_C.sql =========**
PROMPT ===================================================================================== 
