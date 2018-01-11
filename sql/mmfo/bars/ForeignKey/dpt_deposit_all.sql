

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_DEPOSIT_ALL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTDPTALL_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_ALL ADD CONSTRAINT FK_DPTDPTALL_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDPTALL_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_ALL ADD CONSTRAINT FK_DPTDPTALL_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_DEPOSIT_ALL.sql =========*** 
PROMPT ===================================================================================== 
