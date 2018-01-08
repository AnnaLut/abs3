

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CASH_SNAPSHOT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CASHSNAPSHOT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_SNAPSHOT ADD CONSTRAINT FK_CASHSNAPSHOT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_CASHSNAPSHOT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_SNAPSHOT ADD CONSTRAINT XFK_CASHSNAPSHOT FOREIGN KEY (BRANCH, OPDATE)
	  REFERENCES BARS.CASH_OPEN (BRANCH, OPDATE) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CASH_SNAPSHOT.sql =========*** En
PROMPT ===================================================================================== 
