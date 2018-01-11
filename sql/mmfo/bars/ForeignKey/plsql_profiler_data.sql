

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PLSQL_PROFILER_DATA.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint SYS_C00110787 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PLSQL_PROFILER_DATA ADD FOREIGN KEY (RUNID, UNIT_NUMBER)
	  REFERENCES BARS.PLSQL_PROFILER_UNITS (RUNID, UNIT_NUMBER) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PLSQL_PROFILER_DATA.sql =========
PROMPT ===================================================================================== 
