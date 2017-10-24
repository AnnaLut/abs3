

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/REPORTS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  table REPORTS ***
begin 
  execute immediate '
  CREATE TABLE FINMON.REPORTS 
   (	ID NUMBER(18,0), 
	NAME VARCHAR2(65), 
	DESCRIPTION VARCHAR2(150), 
	TEMPLATE VARCHAR2(50), 
	QUERY CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS 
 LOB (QUERY) STORE AS BASICFILE (
  TABLESPACE USERS ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.REPORTS IS '';
COMMENT ON COLUMN FINMON.REPORTS.ID IS '';
COMMENT ON COLUMN FINMON.REPORTS.NAME IS '';
COMMENT ON COLUMN FINMON.REPORTS.DESCRIPTION IS '';
COMMENT ON COLUMN FINMON.REPORTS.TEMPLATE IS '';
COMMENT ON COLUMN FINMON.REPORTS.QUERY IS '';




PROMPT *** Create  constraint NK_REPORTS_DESCRIPTION ***
begin   
 execute immediate '
  ALTER TABLE FINMON.REPORTS MODIFY (DESCRIPTION CONSTRAINT NK_REPORTS_DESCRIPTION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_REPORTS_NAME ***
begin   
 execute immediate '
  ALTER TABLE FINMON.REPORTS MODIFY (NAME CONSTRAINT NK_REPORTS_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_REPORTS_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.REPORTS MODIFY (ID CONSTRAINT NK_REPORTS_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_REPORTS_TEMPLATE ***
begin   
 execute immediate '
  ALTER TABLE FINMON.REPORTS MODIFY (TEMPLATE CONSTRAINT NK_REPORTS_TEMPLATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_REPORTS ***
begin   
 execute immediate '
  ALTER TABLE FINMON.REPORTS ADD CONSTRAINT XPK_REPORTS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REPORTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_REPORTS ON FINMON.REPORTS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/REPORTS.sql =========*** End *** ===
PROMPT ===================================================================================== 
