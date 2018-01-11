

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/GRT_DEPOSITS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DEPOSITS_DEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEPOSITS ADD CONSTRAINT FK_DEPOSITS_DEALS FOREIGN KEY (DEAL_ID)
	  REFERENCES BARS.GRT_DEALS (DEAL_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/GRT_DEPOSITS.sql =========*** End
PROMPT ===================================================================================== 
