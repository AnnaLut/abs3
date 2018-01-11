

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_KOL$BASE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CCKOLBASE_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL$BASE ADD CONSTRAINT FK_CCKOLBASE_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_KOL$BASE.sql =========*** End 
PROMPT ===================================================================================== 
