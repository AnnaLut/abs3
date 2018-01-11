

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/LOG_TABLE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  table LOG_TABLE ***
begin 
  execute immediate '
  CREATE TABLE CDB.LOG_TABLE 
   (	SESSION_ID NUMBER(10,0), 
	PROCEDURE_NAME VARCHAR2(100 CHAR), 
	LOG_LEVEL NUMBER(5,0), 
	LOG_MESSAGE CLOB, 
	SYS_TIMESTAMP TIMESTAMP (6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (LOG_MESSAGE) STORE AS BASICFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.LOG_TABLE IS '';
COMMENT ON COLUMN CDB.LOG_TABLE.SESSION_ID IS '';
COMMENT ON COLUMN CDB.LOG_TABLE.PROCEDURE_NAME IS '';
COMMENT ON COLUMN CDB.LOG_TABLE.LOG_LEVEL IS '';
COMMENT ON COLUMN CDB.LOG_TABLE.LOG_MESSAGE IS '';
COMMENT ON COLUMN CDB.LOG_TABLE.SYS_TIMESTAMP IS '';




PROMPT *** Create  constraint SYS_C00118941 ***
begin   
 execute immediate '
  ALTER TABLE CDB.LOG_TABLE MODIFY (PROCEDURE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118942 ***
begin   
 execute immediate '
  ALTER TABLE CDB.LOG_TABLE MODIFY (SYS_TIMESTAMP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LOG_TABLE ***
grant SELECT                                                                 on LOG_TABLE       to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/LOG_TABLE.sql =========*** End *** ====
PROMPT ===================================================================================== 
