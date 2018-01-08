

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BRANCH_ATTRIBUTE_VALUE.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BRANCHATTRVAL_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_ATTRIBUTE_VALUE ADD CONSTRAINT FK_BRANCHATTRVAL_BRANCH FOREIGN KEY (BRANCH_CODE)
	  REFERENCES BARS.BRANCH (BRANCH) ON DELETE CASCADE DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BRANCH_ATTRIBUTE_VALUE.sql ======
PROMPT ===================================================================================== 
