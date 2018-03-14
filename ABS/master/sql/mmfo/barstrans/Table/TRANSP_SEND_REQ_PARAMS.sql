PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_SEND_REQ_PARAMS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSP_SEND_REQ_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.TRANSP_SEND_REQ_PARAMS 
   (	DATA_ID NUMBER, 
	PARAM_TYPE VARCHAR2(10), 
	TAG VARCHAR2(30), 
	VALUE VARCHAR2(255)
   ) TABLESPACE BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.TRANSP_SEND_REQ_PARAMS IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_REQ_PARAMS.DATA_ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_REQ_PARAMS.PARAM_TYPE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_REQ_PARAMS.TAG IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_REQ_PARAMS.VALUE IS '';




PROMPT *** Create  constraint PK_TRANSP_SEND_REQ_PARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.TRANSP_SEND_REQ_PARAMS ADD CONSTRAINT PK_TRANSP_SEND_REQ_PARAMS PRIMARY KEY (DATA_ID, PARAM_TYPE, TAG)
  USING INDEX TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANSP_SEND_REQ_PARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_TRANSP_SEND_REQ_PARAMS ON BARSTRANS.TRANSP_SEND_REQ_PARAMS (DATA_ID, PARAM_TYPE, TAG) 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_SEND_REQ_PARAMS.sql ======
PROMPT ===================================================================================== 