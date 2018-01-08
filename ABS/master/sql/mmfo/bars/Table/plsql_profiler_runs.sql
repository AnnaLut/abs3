

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PLSQL_PROFILER_RUNS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PLSQL_PROFILER_RUNS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PLSQL_PROFILER_RUNS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PLSQL_PROFILER_RUNS 
   (	RUNID NUMBER, 
	RELATED_RUN NUMBER, 
	RUN_OWNER VARCHAR2(32), 
	RUN_DATE DATE, 
	RUN_COMMENT VARCHAR2(2047), 
	RUN_TOTAL_TIME NUMBER, 
	RUN_SYSTEM_INFO VARCHAR2(2047), 
	RUN_COMMENT1 VARCHAR2(2047), 
	SPARE1 VARCHAR2(256)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PLSQL_PROFILER_RUNS ***
 exec bpa.alter_policies('PLSQL_PROFILER_RUNS');


COMMENT ON TABLE BARS.PLSQL_PROFILER_RUNS IS 'Run-specific information for the PL/SQL profiler';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_RUNS.RUNID IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_RUNS.RELATED_RUN IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_RUNS.RUN_OWNER IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_RUNS.RUN_DATE IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_RUNS.RUN_COMMENT IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_RUNS.RUN_TOTAL_TIME IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_RUNS.RUN_SYSTEM_INFO IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_RUNS.RUN_COMMENT1 IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_RUNS.SPARE1 IS '';




PROMPT *** Create  constraint SYS_C00110781 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PLSQL_PROFILER_RUNS ADD PRIMARY KEY (RUNID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C00110781 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C00110781 ON BARS.PLSQL_PROFILER_RUNS (RUNID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PLSQL_PROFILER_RUNS.sql =========*** E
PROMPT ===================================================================================== 
