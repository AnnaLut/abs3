PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_SEND_REQ.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSP_SEND_REQ ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.TRANSP_SEND_REQ 
   (	ID NUMBER, 
	MAIN_ID NUMBER, 
	URI_ID NUMBER, 
	TYPE_ID NUMBER, 
	INSERT_TIME TIMESTAMP (6), 
	SEND_TIME TIMESTAMP (6), 
	RESP_NUM NUMBER, 
	RESP_CLOB CLOB, 
	RESP_BLOB BLOB, 
	STATE_ID NUMBER, 
	PROCESSED_TIME TIMESTAMP (6)
   ) TABLESPACE BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.TRANSP_SEND_REQ IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_REQ.ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_REQ.MAIN_ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_REQ.URI_ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_REQ.TYPE_ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_REQ.INSERT_TIME IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_REQ.SEND_TIME IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_REQ.RESP_NUM IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_REQ.RESP_CLOB IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_REQ.RESP_BLOB IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_REQ.STATE_ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_REQ.PROCESSED_TIME IS '';




PROMPT *** Create  constraint PK_TRANSP_SEND_REQ ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.TRANSP_SEND_REQ ADD CONSTRAINT PK_TRANSP_SEND_REQ PRIMARY KEY (ID)
  USING INDEX TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANSP_SEND_REQ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_TRANSP_SEND_REQ ON BARSTRANS.TRANSP_SEND_REQ (ID) 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_SEND_REQ.sql =========*** 
PROMPT ===================================================================================== 