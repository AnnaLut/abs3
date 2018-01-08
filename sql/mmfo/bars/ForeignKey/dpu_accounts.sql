

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPU_ACCOUNTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPUACCOUNTS_DPUDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_ACCOUNTS ADD CONSTRAINT FK_DPUACCOUNTS_DPUDEAL FOREIGN KEY (KF, DPUID)
	  REFERENCES BARS.DPU_DEAL (KF, DPU_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUACCOUNTS_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_ACCOUNTS ADD CONSTRAINT FK_DPUACCOUNTS_ACCOUNTS FOREIGN KEY (KF, ACCID)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPU_ACCOUNTS.sql =========*** End
PROMPT ===================================================================================== 
