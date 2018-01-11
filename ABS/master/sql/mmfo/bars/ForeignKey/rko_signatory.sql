

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/RKO_SIGNATORY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_RKO_SIGNATORY_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_SIGNATORY ADD CONSTRAINT FK_RKO_SIGNATORY_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/RKO_SIGNATORY.sql =========*** En
PROMPT ===================================================================================== 
