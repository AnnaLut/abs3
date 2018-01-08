

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DWH_REPORT_LINKS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DWH_REPORT_LINKS1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_REPORT_LINKS ADD CONSTRAINT FK_DWH_REPORT_LINKS1 FOREIGN KEY (REPORT_ID)
	  REFERENCES BARS.DWH_REPORTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DWH_REPORT_LINKS.sql =========***
PROMPT ===================================================================================== 
