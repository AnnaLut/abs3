

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_BONUS_REQUESTS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTBONUSREQ_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBONUSREQ_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_DPTDPTALL2 FOREIGN KEY (KF, DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBONUSREQ_DPTREQS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_DPTREQS2 FOREIGN KEY (KF, REQ_ID)
	  REFERENCES BARS.DPT_REQUESTS (KF, REQ_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBONUSREQ_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBONUSREQ_REQSTATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_REQSTATE FOREIGN KEY (REQUEST_STATE)
	  REFERENCES BARS.DPT_BONUS_REQUEST_STATES (STATE_CODE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBONUSREQ_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_STAFF FOREIGN KEY (REQUEST_USER)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBONUSREQ_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_STAFF2 FOREIGN KEY (PROCESS_USER)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBONUSREQ_DPTBONUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_DPTBONUS FOREIGN KEY (BONUS_ID)
	  REFERENCES BARS.DPT_BONUSES (BONUS_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_BONUS_REQUESTS.sql =========*
PROMPT ===================================================================================== 
