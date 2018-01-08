

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_EXTREFUSALS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTEXTREFUSALS_DPTDPTALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTREFUSALS ADD CONSTRAINT FK_DPTEXTREFUSALS_DPTDPTALL FOREIGN KEY (DPTID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTEXTREFUSALS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTREFUSALS ADD CONSTRAINT FK_DPTEXTREFUSALS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTEXTREFUSALS_STAFF1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTREFUSALS ADD CONSTRAINT FK_DPTEXTREFUSALS_STAFF1 FOREIGN KEY (REQ_USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTEXTREFUSALS_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTREFUSALS ADD CONSTRAINT FK_DPTEXTREFUSALS_STAFF2 FOREIGN KEY (VRF_USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_EXTREFUSALS.sql =========*** 
PROMPT ===================================================================================== 
