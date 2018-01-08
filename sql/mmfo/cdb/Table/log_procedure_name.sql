

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/LOG_PROCEDURE_NAME.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table LOG_PROCEDURE_NAME ***
begin 
  execute immediate '
  CREATE TABLE CDB.LOG_PROCEDURE_NAME 
   (	PROCEDURE_NAME VARCHAR2(100 CHAR)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.LOG_PROCEDURE_NAME IS '';
COMMENT ON COLUMN CDB.LOG_PROCEDURE_NAME.PROCEDURE_NAME IS '';




PROMPT *** Create  constraint PK_LOG_PROCEDURE_NAME ***
begin   
 execute immediate '
  ALTER TABLE CDB.LOG_PROCEDURE_NAME ADD CONSTRAINT PK_LOG_PROCEDURE_NAME PRIMARY KEY (PROCEDURE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118878 ***
begin   
 execute immediate '
  ALTER TABLE CDB.LOG_PROCEDURE_NAME MODIFY (PROCEDURE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_LOG_PROCEDURE_NAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_LOG_PROCEDURE_NAME ON CDB.LOG_PROCEDURE_NAME (PROCEDURE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LOG_PROCEDURE_NAME ***
grant SELECT                                                                 on LOG_PROCEDURE_NAME to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/LOG_PROCEDURE_NAME.sql =========*** End
PROMPT ===================================================================================== 
