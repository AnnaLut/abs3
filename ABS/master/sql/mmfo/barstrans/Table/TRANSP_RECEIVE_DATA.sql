PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_RECEIVE_DATA.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSP_RECEIVE_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.TRANSP_RECEIVE_DATA 
   (	ID NUMBER, 
	TYPE_ID NUMBER, 
	D_CLOB CLOB, 
	D_BLOB BLOB, 
	INSERT_TIME TIMESTAMP (6), 
	STATE_ID NUMBER, 
	PROCESSED_TIME TIMESTAMP (6)
   ) NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.TRANSP_RECEIVE_DATA IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_DATA.ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_DATA.TYPE_ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_DATA.D_CLOB IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_DATA.D_BLOB IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_DATA.INSERT_TIME IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_DATA.STATE_ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_DATA.PROCESSED_TIME IS '';




PROMPT *** Create  constraint PK_TRANSP_RECEIVE_DATA ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.TRANSP_RECEIVE_DATA ADD CONSTRAINT PK_TRANSP_RECEIVE_DATA PRIMARY KEY (ID)
  USING INDEX TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANSP_RECEIVE_DATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_TRANSP_RECEIVE_DATA ON BARSTRANS.TRANSP_RECEIVE_DATA (ID) 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TRANSP_RECEIVE_DATA ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on TRANSP_RECEIVE_DATA to BARS;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on TRANSP_RECEIVE_DATA to NBU_GATEWAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_RECEIVE_DATA.sql =========
PROMPT ===================================================================================== 