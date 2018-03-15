PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_RECEIVE_LOG.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSP_RECEIVE_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.TRANSP_RECEIVE_LOG 
   (	ID NUMBER, 
	DATE_ID NUMBER, 
	ACT VARCHAR2(255), 
	STATE VARCHAR2(255), 
	MESSAGE VARCHAR2(4000), 
	MOD_DATE TIMESTAMP (6)
   ) TABLESPACE BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.TRANSP_RECEIVE_LOG IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_LOG.ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_LOG.DATE_ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_LOG.ACT IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_LOG.STATE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_LOG.MESSAGE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_RECEIVE_LOG.MOD_DATE IS '';




PROMPT *** Create  constraint PK_TRANSP_RECEIVE_LOG ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.TRANSP_RECEIVE_LOG ADD CONSTRAINT PK_TRANSP_RECEIVE_LOG PRIMARY KEY (ID)
  USING INDEX TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANSP_RECEIVE_LOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_TRANSP_RECEIVE_LOG ON BARSTRANS.TRANSP_RECEIVE_LOG (ID) 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_RECEIVE_LOG.sql =========*
PROMPT ===================================================================================== 