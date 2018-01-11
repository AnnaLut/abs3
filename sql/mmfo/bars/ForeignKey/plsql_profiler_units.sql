

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PLSQL_PROFILER_UNITS.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint SYS_C00110784 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PLSQL_PROFILER_UNITS ADD FOREIGN KEY (RUNID)
	  REFERENCES BARS.PLSQL_PROFILER_RUNS (RUNID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PLSQL_PROFILER_UNITS.sql ========
PROMPT ===================================================================================== 
