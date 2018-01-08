

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_POWER_OF_ATTORNEYS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WCSPWROFATTRNS_B_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_POWER_OF_ATTORNEYS ADD CONSTRAINT FK_WCSPWROFATTRNS_B_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_POWER_OF_ATTORNEYS.sql ======
PROMPT ===================================================================================== 
