

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/REPRINT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_REPRINT_REPORTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPRINT ADD CONSTRAINT FK_REPRINT_REPORTS FOREIGN KEY (ID)
	  REFERENCES BARS.REPORTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/REPRINT.sql =========*** End *** 
PROMPT ===================================================================================== 
