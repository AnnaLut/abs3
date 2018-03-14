PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_RECEIVE_RESP.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSP_RECEIVE_RESP ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.TRANSP_RECEIVE_RESP 
   (	ID NUMBER, 
	ID_REQ NUMBER, 
	D_CLOB CLOB, 
	D_BLOB BLOB, 
	INSERT_TIME TIMESTAMP (6)
   ) TABLESPACE BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.TRANSP_RECEIVE_RESP IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_RESP.ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_RESP.ID_REQ IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_RESP.D_CLOB IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_RESP.D_BLOB IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_RESP.INSERT_TIME IS '';




PROMPT *** Create  constraint PK_TRANSP_RECEIVE_RESP ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.TRANSP_RECEIVE_RESP ADD CONSTRAINT PK_TRANSP_RECEIVE_RESP PRIMARY KEY (ID)
  USING INDEX TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANSP_RECEIVE_RESP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_TRANSP_RECEIVE_RESP ON BARSTRANS.TRANSP_RECEIVE_RESP (ID) 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_RECEIVE_RESP.sql =========
PROMPT ===================================================================================== 