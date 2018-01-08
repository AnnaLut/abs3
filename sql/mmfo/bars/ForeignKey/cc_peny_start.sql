

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_PENY_START.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CCPENYSTART_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PENY_START ADD CONSTRAINT FK_CCPENYSTART_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_PENY_START.sql =========*** En
PROMPT ===================================================================================== 
