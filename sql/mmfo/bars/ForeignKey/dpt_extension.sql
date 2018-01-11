

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_EXTENSION.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTEXT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION ADD CONSTRAINT FK_DPTEXT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTEXT_DPTEXTMETHOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION ADD CONSTRAINT FK_DPTEXT_DPTEXTMETHOD FOREIGN KEY (METHOD)
	  REFERENCES BARS.DPT_EXTENSION_METHOD (METHOD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTEXT_INTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION ADD CONSTRAINT FK_DPTEXT_INTOP FOREIGN KEY (OP)
	  REFERENCES BARS.INT_OP (OP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_EXTENSION.sql =========*** En
PROMPT ===================================================================================== 
