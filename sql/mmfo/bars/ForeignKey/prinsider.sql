

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PRINSIDER.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PRINSIDER_PRINSIDER ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRINSIDER ADD CONSTRAINT FK_PRINSIDER_PRINSIDER FOREIGN KEY (PRINSIDERLV1)
	  REFERENCES BARS.PRINSIDER (PRINSIDER) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PRINSIDER.sql =========*** End **
PROMPT ===================================================================================== 
