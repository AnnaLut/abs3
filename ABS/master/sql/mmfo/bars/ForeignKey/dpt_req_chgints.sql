

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_REQ_CHGINTS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTREQCHGINTS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_CHGINTS ADD CONSTRAINT FK_DPTREQCHGINTS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQCHGINTS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_CHGINTS ADD CONSTRAINT FK_DPTREQCHGINTS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQCHGINTS_DPTREQS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_CHGINTS ADD CONSTRAINT FK_DPTREQCHGINTS_DPTREQS2 FOREIGN KEY (KF, REQ_ID)
	  REFERENCES BARS.DPT_REQUESTS (KF, REQ_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_REQ_CHGINTS.sql =========*** 
PROMPT ===================================================================================== 
