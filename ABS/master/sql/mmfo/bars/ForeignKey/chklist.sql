

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CHKLIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CHKLIST_INCHARGE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST ADD CONSTRAINT FK_CHKLIST_INCHARGE FOREIGN KEY (F_IN_CHARGE)
	  REFERENCES BARS.IN_CHARGE_LIST (IN_CHARGE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CHKLIST.sql =========*** End *** 
PROMPT ===================================================================================== 
