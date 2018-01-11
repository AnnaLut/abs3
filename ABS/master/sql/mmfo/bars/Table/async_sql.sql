

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ASYNC_SQL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ASYNC_SQL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ASYNC_SQL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ASYNC_SQL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ASYNC_SQL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ASYNC_SQL 
   (	SQL_ID NUMBER, 
	SQL_TEXT VARCHAR2(4000), 
	SESSION_PARAMS VARCHAR2(200), 
	PARALLEL_PARAMS VARCHAR2(200), 
	USE_HPROF CHAR(1) DEFAULT ''N''
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ASYNC_SQL ***
 exec bpa.alter_policies('ASYNC_SQL');


COMMENT ON TABLE BARS.ASYNC_SQL IS 'Довідник SQL запитів';
COMMENT ON COLUMN BARS.ASYNC_SQL.SQL_ID IS 'Ідентифікатор запита';
COMMENT ON COLUMN BARS.ASYNC_SQL.SQL_TEXT IS 'Текст запита';
COMMENT ON COLUMN BARS.ASYNC_SQL.SESSION_PARAMS IS 'Параметри сессії';
COMMENT ON COLUMN BARS.ASYNC_SQL.PARALLEL_PARAMS IS 'Параметри паралельного виконання';
COMMENT ON COLUMN BARS.ASYNC_SQL.USE_HPROF IS '';




PROMPT *** Create  constraint PK_ASNSQL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_SQL ADD CONSTRAINT PK_ASNSQL PRIMARY KEY (SQL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ASNSQL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ASNSQL ON BARS.ASYNC_SQL (SQL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ASYNC_SQL ***
grant SELECT                                                                 on ASYNC_SQL       to BARSREADER_ROLE;
grant SELECT                                                                 on ASYNC_SQL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ASYNC_SQL       to BARS_DM;
grant SELECT                                                                 on ASYNC_SQL       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ASYNC_SQL.sql =========*** End *** ===
PROMPT ===================================================================================== 
