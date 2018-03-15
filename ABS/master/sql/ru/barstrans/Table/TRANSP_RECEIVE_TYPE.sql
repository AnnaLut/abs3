PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_RECEIVE_TYPE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSP_RECEIVE_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.TRANSP_RECEIVE_TYPE 
   (	ID NUMBER, 
	TYPE_NAME VARCHAR2(255), 
	TYPE_DESC VARCHAR2(255), 
	SESS_TYPE NUMBER(1,0), 
	ACT_TYPE VARCHAR2(255), 
	LOGING NUMBER, 
	S_PRIOR NUMBER(2,0), 
	DATA_TYPE VARCHAR2(10), 
	CONT_TYPE VARCHAR2(50), 
	CONV_2_JSON NUMBER(1,0), 
	COMPRESS_TYPE VARCHAR2(10), 
	BASE_64 NUMBER(1,0), 
	CHECK_SUM VARCHAR2(10)
   ) TABLESPACE BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.TRANSP_RECEIVE_TYPE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_TYPE.ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_TYPE.TYPE_NAME IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_TYPE.TYPE_DESC IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_TYPE.SESS_TYPE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_TYPE.ACT_TYPE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_TYPE.LOGING IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_TYPE.S_PRIOR IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_TYPE.DATA_TYPE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_TYPE.CONT_TYPE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_TYPE.CONV_2_JSON IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_TYPE.COMPRESS_TYPE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_TYPE.BASE_64 IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_TYPE.CHECK_SUM IS '';




PROMPT *** Create  constraint PK_TRANSP_RECEIVE_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.TRANSP_RECEIVE_TYPE ADD CONSTRAINT PK_TRANSP_RECEIVE_TYPE PRIMARY KEY (ID)
  USING INDEX TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANSP_RECEIVE_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_TRANSP_RECEIVE_TYPE ON BARSTRANS.TRANSP_RECEIVE_TYPE (ID) 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index TYPE_TRANSP_RECEIVE_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.TYPE_TRANSP_RECEIVE_TYPE ON BARSTRANS.TRANSP_RECEIVE_TYPE (TYPE_NAME) 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TRANSP_RECEIVE_TYPE ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on TRANSP_RECEIVE_TYPE to BARS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_RECEIVE_TYPE.sql =========
PROMPT ===================================================================================== 