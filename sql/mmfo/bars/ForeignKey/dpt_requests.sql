

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_REQUESTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTREQS_DPTREQTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS ADD CONSTRAINT FK_DPTREQS_DPTREQTYPES FOREIGN KEY (REQTYPE_ID)
	  REFERENCES BARS.DPT_REQ_TYPES (REQTYPE_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS ADD CONSTRAINT FK_DPTREQS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS ADD CONSTRAINT FK_DPTREQS_STAFF FOREIGN KEY (REQ_CRUSERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQS_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS ADD CONSTRAINT FK_DPTREQS_STAFF2 FOREIGN KEY (REQ_PRCUSERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS ADD CONSTRAINT FK_DPTREQS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQS_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS ADD CONSTRAINT FK_DPTREQS_DPTDPTALL2 FOREIGN KEY (KF, DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_REQUESTS.sql =========*** End
PROMPT ===================================================================================== 
