PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_SEND_LOG.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSP_SEND_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.TRANSP_SEND_LOG 
   (	ID NUMBER, 
	REQ_ID NUMBER, 
	SUB_REQ NUMBER, 
	CHK_REQ NUMBER, 
	ACT VARCHAR2(255), 
	STATE VARCHAR2(255), 
	MESSAGE VARCHAR2(4000), 
	MOD_DATE TIMESTAMP (6)
   ) TABLESPACE BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.TRANSP_SEND_LOG IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_LOG.ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_LOG.REQ_ID IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_LOG.SUB_REQ IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_LOG.CHK_REQ IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_LOG.ACT IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_LOG.STATE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_LOG.MESSAGE IS '';
COMMENT ON COLUMN BARSTRANS.TRANSP_SEND_LOG.MOD_DATE IS '';




PROMPT *** Create  constraint PK_TRANSP_SEND_LOG ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.TRANSP_SEND_LOG ADD CONSTRAINT PK_TRANSP_SEND_LOG PRIMARY KEY (ID)
  USING INDEX TABLESPACE BRSMDLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANSP_SEND_LOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_TRANSP_SEND_LOG ON BARSTRANS.TRANSP_SEND_LOG (ID) 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IND_TRANSP_SEND_LOG_D_ID ***
begin   
 execute immediate '
  CREATE INDEX BARSTRANS.IND_TRANSP_SEND_LOG_D_ID ON BARSTRANS.TRANSP_SEND_LOG (REQ_ID) 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/TRANSP_SEND_LOG.sql =========*** 
PROMPT ===================================================================================== 