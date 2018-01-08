

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_CHKLIST.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWCHKLIST_CHKLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_CHKLIST ADD CONSTRAINT FK_SWCHKLIST_CHKLIST FOREIGN KEY (IDCHK)
	  REFERENCES BARS.CHKLIST (IDCHK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_CHKLIST.sql =========*** End *
PROMPT ===================================================================================== 
