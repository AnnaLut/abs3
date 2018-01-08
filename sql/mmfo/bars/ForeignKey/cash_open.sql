

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CASH_OPEN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CASHOPEN_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_OPEN ADD CONSTRAINT FK_CASHOPEN_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CASH_OPEN.sql =========*** End **
PROMPT ===================================================================================== 
