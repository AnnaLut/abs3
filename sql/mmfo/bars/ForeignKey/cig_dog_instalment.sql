

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CIG_DOG_INSTALMENT.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CIGDOGINST_CIGDOGGENERAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT ADD CONSTRAINT FK_CIGDOGINST_CIGDOGGENERAL FOREIGN KEY (DOG_ID, BRANCH)
	  REFERENCES BARS.CIG_DOG_GENERAL (ID, BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CIG_DOG_INSTALMENT.sql =========*
PROMPT ===================================================================================== 
