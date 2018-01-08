

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_REQ_DELDEALS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTREQDELDEALS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_DELDEALS ADD CONSTRAINT FK_DPTREQDELDEALS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQDELDEALS_DPTREQS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_DELDEALS ADD CONSTRAINT FK_DPTREQDELDEALS_DPTREQS2 FOREIGN KEY (KF, REQ_ID)
	  REFERENCES BARS.DPT_REQUESTS (KF, REQ_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQDELDEALS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_DELDEALS ADD CONSTRAINT FK_DPTREQDELDEALS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQDELDEALS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_DELDEALS ADD CONSTRAINT FK_DPTREQDELDEALS_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_REQ_DELDEALS.sql =========***
PROMPT ===================================================================================== 
