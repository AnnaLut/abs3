PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_URI.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSP_URI ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.TRANSP_URI 
   (	URI_ID NUMBER, 
	URI_DESC VARCHAR2(255), 
	SEND_TYPE NUMBER, 
	BASE_HOST VARCHAR2(255), 
	REQ_PATH VARCHAR2(255), 
	CHK_PATH VARCHAR2(255), 
	AUTH_USER VARCHAR2(255), 
	AUTH_PATH VARCHAR2(255), 
	IS_ACTIVE NUMBER(1,0), 
	IS_LOCAL NUMBER(1,0), 
	IS_DEFAULT NUMBER(1,0), 
	KF NUMBER(6,0)
   ) TABLESPACE BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.TRANSP_URI IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_URI.URI_ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_URI.URI_DESC IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_URI.SEND_TYPE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_URI.BASE_HOST IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_URI.REQ_PATH IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_URI.CHK_PATH IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_URI.AUTH_USER IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_URI.AUTH_PATH IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_URI.IS_ACTIVE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_URI.IS_LOCAL IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_URI.IS_DEFAULT IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_URI.KF IS '';




PROMPT *** Create  constraint PK_TRANSP_URI ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.TRANSP_URI ADD CONSTRAINT PK_TRANSP_URI PRIMARY KEY (URI_ID)
  USING INDEX TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANSP_URI ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_TRANSP_URI ON BARSTRANS.TRANSP_URI (URI_ID) 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_URI.sql =========*** End *
PROMPT ===================================================================================== 