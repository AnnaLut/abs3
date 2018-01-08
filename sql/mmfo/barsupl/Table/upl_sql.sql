

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_SQL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_SQL ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_SQL 
   (	SQL_ID NUMBER, 
	SQL_TEXT CLOB, 
	BEFORE_PROC CLOB, 
	AFTER_PROC CLOB, 
	DESCRIPT VARCHAR2(250), 
	VERS VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD 
 LOB (SQL_TEXT) STORE AS BASICFILE (
  TABLESPACE BRSUPLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (BEFORE_PROC) STORE AS BASICFILE (
  TABLESPACE BRSUPLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (AFTER_PROC) STORE AS BASICFILE (
  TABLESPACE BRSUPLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_SQL IS '';
COMMENT ON COLUMN BARSUPL.UPL_SQL.SQL_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_SQL.SQL_TEXT IS '';
COMMENT ON COLUMN BARSUPL.UPL_SQL.BEFORE_PROC IS '';
COMMENT ON COLUMN BARSUPL.UPL_SQL.AFTER_PROC IS '';
COMMENT ON COLUMN BARSUPL.UPL_SQL.DESCRIPT IS '';
COMMENT ON COLUMN BARSUPL.UPL_SQL.VERS IS '';




PROMPT *** Create  constraint PK_SQL ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_SQL ADD CONSTRAINT PK_SQL PRIMARY KEY (SQL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SQL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_SQL ON BARSUPL.UPL_SQL (SQL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_SQL ***
grant SELECT                                                                 on UPL_SQL         to BARSREADER_ROLE;
grant SELECT                                                                 on UPL_SQL         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_SQL.sql =========*** End *** ==
PROMPT ===================================================================================== 
