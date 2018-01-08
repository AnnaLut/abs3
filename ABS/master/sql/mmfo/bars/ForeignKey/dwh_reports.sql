

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DWH_REPORTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DWHREPORTS_DWHREPORTSTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_REPORTS ADD CONSTRAINT FK_DWHREPORTS_DWHREPORTSTYPE FOREIGN KEY (TYPEID)
	  REFERENCES BARS.DWH_REPORT_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DWH_REPORTS.sql =========*** End 
PROMPT ===================================================================================== 
