

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_BCK_REPORTS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WCSBCKREPORTS_WCSBCK ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_REPORTS ADD CONSTRAINT FK_WCSBCKREPORTS_WCSBCK FOREIGN KEY (BCK_ID)
	  REFERENCES BARS.WCS_BCK (BCK_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_BCK_REPORTS.sql =========*** 
PROMPT ===================================================================================== 
