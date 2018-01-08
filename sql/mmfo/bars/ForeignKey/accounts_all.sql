

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACCOUNTS_ALL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCOUNTSALL_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_ALL ADD CONSTRAINT FK_ACCOUNTSALL_BANKS FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSALL_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_ALL ADD CONSTRAINT FK_ACCOUNTSALL_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACCOUNTS_ALL.sql =========*** End
PROMPT ===================================================================================== 
