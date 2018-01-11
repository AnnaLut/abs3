

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PLSQL_PROFILER_UNITS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PLSQL_PROFILER_UNITS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PLSQL_PROFILER_UNITS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PLSQL_PROFILER_UNITS 
   (	RUNID NUMBER, 
	UNIT_NUMBER NUMBER, 
	UNIT_TYPE VARCHAR2(32), 
	UNIT_OWNER VARCHAR2(32), 
	UNIT_NAME VARCHAR2(32), 
	UNIT_TIMESTAMP DATE, 
	TOTAL_TIME NUMBER DEFAULT 0, 
	SPARE1 NUMBER, 
	SPARE2 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PLSQL_PROFILER_UNITS ***
 exec bpa.alter_policies('PLSQL_PROFILER_UNITS');


COMMENT ON TABLE BARS.PLSQL_PROFILER_UNITS IS 'Information about each library unit in a run';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_UNITS.RUNID IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_UNITS.UNIT_NUMBER IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_UNITS.UNIT_TYPE IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_UNITS.UNIT_OWNER IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_UNITS.UNIT_NAME IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_UNITS.UNIT_TIMESTAMP IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_UNITS.TOTAL_TIME IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_UNITS.SPARE1 IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_UNITS.SPARE2 IS '';




PROMPT *** Create  constraint SYS_C00110782 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PLSQL_PROFILER_UNITS MODIFY (TOTAL_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00110783 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PLSQL_PROFILER_UNITS ADD PRIMARY KEY (RUNID, UNIT_NUMBER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C00110783 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C00110783 ON BARS.PLSQL_PROFILER_UNITS (RUNID, UNIT_NUMBER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PLSQL_PROFILER_UNITS ***
grant SELECT                                                                 on PLSQL_PROFILER_UNITS to BARSREADER_ROLE;
grant SELECT                                                                 on PLSQL_PROFILER_UNITS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PLSQL_PROFILER_UNITS.sql =========*** 
PROMPT ===================================================================================== 
