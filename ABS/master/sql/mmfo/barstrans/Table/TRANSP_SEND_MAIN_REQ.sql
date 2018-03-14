PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_SEND_MAIN_REQ.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSP_SEND_MAIN_REQ ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.TRANSP_SEND_MAIN_REQ 
   (	ID NUMBER, 
	SEND_TYPE NUMBER, 
	N_DATE NUMBER, 
	C_DATA CLOB, 
	B_DATA BLOB, 
	INS_DATE TIMESTAMP (6), 
	REQ_DATE CLOB, 
	STATUS NUMBER, 
	DONE_DATE TIMESTAMP (6)
   ) TABLESPACE BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.TRANSP_SEND_MAIN_REQ IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_MAIN_REQ.ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_MAIN_REQ.SEND_TYPE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_MAIN_REQ.N_DATE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_MAIN_REQ.C_DATA IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_MAIN_REQ.B_DATA IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_MAIN_REQ.INS_DATE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_MAIN_REQ.REQ_DATE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_MAIN_REQ.STATUS IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_MAIN_REQ.DONE_DATE IS '';




PROMPT *** Create  constraint PK_TRANSP_SEND_MAIN_REQ ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.TRANSP_SEND_MAIN_REQ ADD CONSTRAINT PK_TRANSP_SEND_MAIN_REQ PRIMARY KEY (ID)
  USING INDEX TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANSP_SEND_MAIN_REQ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_TRANSP_SEND_MAIN_REQ ON BARSTRANS.TRANSP_SEND_MAIN_REQ (ID) 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_SEND_MAIN_REQ.sql ========
PROMPT ===================================================================================== 