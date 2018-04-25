PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_SEND_RESP_PARAMS.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSP_SEND_RESP_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.TRANSP_SEND_RESP_PARAMS 
   (	REQ_ID NUMBER, 
	PARAM_TYPE VARCHAR2(10), 
	TAG VARCHAR2(30), 
	VALUE VARCHAR2(255)
   ) TABLESPACE BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index barstrans.i_transp_send_resp_params on barstrans.transp_send_resp_params (req_id) tablespace brsmdli';
exception
    when name_already_used then
         null;
end;
/

COMMENT ON TABLE BARSTRANS.TRANSP_SEND_RESP_PARAMS IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_RESP_PARAMS.REQ_ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_RESP_PARAMS.PARAM_TYPE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_RESP_PARAMS.TAG IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_RESP_PARAMS.VALUE IS '';


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_SEND_RESP_PARAMS.sql =====
PROMPT ===================================================================================== 