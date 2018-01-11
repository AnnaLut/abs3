

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BRANCH.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BRANCHTIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH ADD CONSTRAINT FK_BRANCHTIP FOREIGN KEY (DESCRIPTION)
	  REFERENCES BARS.BRANCH_TIP (TIP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BRANCH.sql =========*** End *** =
PROMPT ===================================================================================== 
