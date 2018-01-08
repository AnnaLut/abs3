

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TM_CARDS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TMCARDS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.TM_CARDS ADD CONSTRAINT FK_TMCARDS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TM_CARDS.sql =========*** End ***
PROMPT ===================================================================================== 
