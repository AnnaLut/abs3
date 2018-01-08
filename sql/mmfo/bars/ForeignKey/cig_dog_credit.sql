

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CIG_DOG_CREDIT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CIGDOGCREDIT_CIGDOGGENERAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_CREDIT ADD CONSTRAINT FK_CIGDOGCREDIT_CIGDOGGENERAL FOREIGN KEY (DOG_ID, BRANCH)
	  REFERENCES BARS.CIG_DOG_GENERAL (ID, BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CIG_DOG_CREDIT.sql =========*** E
PROMPT ===================================================================================== 
