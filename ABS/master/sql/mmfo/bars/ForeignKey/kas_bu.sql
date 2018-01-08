

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KAS_BU.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_KASBU_IDS ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_BU ADD CONSTRAINT FK_KASBU_IDS FOREIGN KEY (IDS)
	  REFERENCES BARS.KAS_U (IDS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KASBU_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_BU ADD CONSTRAINT FK_KASBU_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KAS_BU.sql =========*** End *** =
PROMPT ===================================================================================== 
