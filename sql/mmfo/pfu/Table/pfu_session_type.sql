

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_SESSION_TYPE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_SESSION_TYPE ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_SESSION_TYPE 
   (	ID NUMBER(5,0), 
	SESSION_TYPE_CODE VARCHAR2(30 CHAR), 
	SESSION_TYPE_NAME VARCHAR2(300 CHAR), 
	WS_ACTION_CODE VARCHAR2(100 CHAR), 
	PFU_METHOD_CODE VARCHAR2(100 CHAR), 
	PROCESS_RESPONSE_PROCEDURE VARCHAR2(100 CHAR), 
	PROCESS_FAILURE_PROCEDURE VARCHAR2(100 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_SESSION_TYPE IS '';
COMMENT ON COLUMN PFU.PFU_SESSION_TYPE.ID IS '';
COMMENT ON COLUMN PFU.PFU_SESSION_TYPE.SESSION_TYPE_CODE IS '';
COMMENT ON COLUMN PFU.PFU_SESSION_TYPE.SESSION_TYPE_NAME IS '';
COMMENT ON COLUMN PFU.PFU_SESSION_TYPE.WS_ACTION_CODE IS '';
COMMENT ON COLUMN PFU.PFU_SESSION_TYPE.PFU_METHOD_CODE IS '';
COMMENT ON COLUMN PFU.PFU_SESSION_TYPE.PROCESS_RESPONSE_PROCEDURE IS '';
COMMENT ON COLUMN PFU.PFU_SESSION_TYPE.PROCESS_FAILURE_PROCEDURE IS '';




PROMPT *** Create  constraint PK_PFU_SESSION_TYPE ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SESSION_TYPE ADD CONSTRAINT PK_PFU_SESSION_TYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111492 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SESSION_TYPE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111493 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SESSION_TYPE MODIFY (SESSION_TYPE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111494 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SESSION_TYPE MODIFY (SESSION_TYPE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_SESSION_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_SESSION_TYPE ON PFU.PFU_SESSION_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_SESSION_TYPE ***
grant SELECT                                                                 on PFU_SESSION_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_SESSION_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_SESSION_TYPE.sql =========*** End *
PROMPT ===================================================================================== 
