

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FIN_TXT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FIN_TXT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_TXT ADD CONSTRAINT FK_FIN_TXT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FIN_TXT.sql =========*** End *** 
PROMPT ===================================================================================== 
