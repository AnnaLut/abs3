

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PLSQL_PROFILER_DATA.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PLSQL_PROFILER_DATA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PLSQL_PROFILER_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.PLSQL_PROFILER_DATA 
   (	RUNID NUMBER, 
	UNIT_NUMBER NUMBER, 
	LINE# NUMBER, 
	TOTAL_OCCUR NUMBER, 
	TOTAL_TIME NUMBER, 
	MIN_TIME NUMBER, 
	MAX_TIME NUMBER, 
	SPARE1 NUMBER, 
	SPARE2 NUMBER, 
	SPARE3 NUMBER, 
	SPARE4 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PLSQL_PROFILER_DATA ***
 exec bpa.alter_policies('PLSQL_PROFILER_DATA');


COMMENT ON TABLE BARS.PLSQL_PROFILER_DATA IS 'Accumulated data from all profiler runs';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_DATA.RUNID IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_DATA.UNIT_NUMBER IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_DATA.LINE# IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_DATA.TOTAL_OCCUR IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_DATA.TOTAL_TIME IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_DATA.MIN_TIME IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_DATA.MAX_TIME IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_DATA.SPARE1 IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_DATA.SPARE2 IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_DATA.SPARE3 IS '';
COMMENT ON COLUMN BARS.PLSQL_PROFILER_DATA.SPARE4 IS '';




PROMPT *** Create  constraint SYS_C00110785 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PLSQL_PROFILER_DATA MODIFY (LINE# NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00110787 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PLSQL_PROFILER_DATA ADD FOREIGN KEY (RUNID, UNIT_NUMBER)
	  REFERENCES BARS.PLSQL_PROFILER_UNITS (RUNID, UNIT_NUMBER) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00110786 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PLSQL_PROFILER_DATA ADD PRIMARY KEY (RUNID, UNIT_NUMBER, LINE#)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C00110786 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C00110786 ON BARS.PLSQL_PROFILER_DATA (RUNID, UNIT_NUMBER, LINE#) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PLSQL_PROFILER_DATA.sql =========*** E
PROMPT ===================================================================================== 
