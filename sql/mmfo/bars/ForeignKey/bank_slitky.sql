

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BANK_SLITKY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BANK_SLITKY_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_SLITKY ADD CONSTRAINT FK_BANK_SLITKY_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKSL_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_SLITKY ADD CONSTRAINT FK_BANKSL_TABVAL FOREIGN KEY (MET)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BANK_SLITKY.sql =========*** End 
PROMPT ===================================================================================== 
