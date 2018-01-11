

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BSA.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BSA_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.BSA ADD CONSTRAINT FK_BSA_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BSA.sql =========*** End *** ====
PROMPT ===================================================================================== 
