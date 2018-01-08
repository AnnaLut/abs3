

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TMP_REZ_RISK.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_REZ_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REZ_RISK ADD CONSTRAINT FK_REZ_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TMP_REZ_RISK.sql =========*** End
PROMPT ===================================================================================== 
