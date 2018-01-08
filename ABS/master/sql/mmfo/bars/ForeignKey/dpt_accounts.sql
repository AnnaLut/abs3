

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_ACCOUNTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTACCOUNTS_DPTDPTALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_ACCOUNTS ADD CONSTRAINT FK_DPTACCOUNTS_DPTDPTALL FOREIGN KEY (DPTID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTACCOUNTS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_ACCOUNTS ADD CONSTRAINT FK_DPTACCOUNTS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_ACCOUNTS.sql =========*** End
PROMPT ===================================================================================== 
