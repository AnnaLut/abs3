

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CASH_BRANCH_LIMIT.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CASH_BRANCH_LIMIT_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_BRANCH_LIMIT ADD CONSTRAINT FK_CASH_BRANCH_LIMIT_KV FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CASHBRANCHLIMIT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_BRANCH_LIMIT ADD CONSTRAINT FK_CASHBRANCHLIMIT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CASH_BRANCH_LIMIT.sql =========**
PROMPT ===================================================================================== 
