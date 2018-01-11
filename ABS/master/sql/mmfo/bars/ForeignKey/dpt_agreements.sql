

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_AGREEMENTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTAGRMNTS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_CUSTOMER FOREIGN KEY (CUST_ID)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_DPTVIDDFLAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_DPTVIDDFLAGS FOREIGN KEY (AGRMNT_TYPE)
	  REFERENCES BARS.DPT_VIDD_FLAGS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_DOCSCHEME FOREIGN KEY (TEMPLATE_ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_BANKS FOREIGN KEY (TRANSFER_BANK)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_DPTDPTALL2 FOREIGN KEY (KF, DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_DPTREQS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_DPTREQS3 FOREIGN KEY (KF, COMISS_REQID)
	  REFERENCES BARS.DPT_REQUESTS (KF, REQ_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_DPTREQS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_DPTREQS FOREIGN KEY (KF, RATE_REQID)
	  REFERENCES BARS.DPT_REQUESTS (KF, REQ_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_DPTTRUSTEE2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_DPTTRUSTEE2 FOREIGN KEY (KF, TRUSTEE_ID)
	  REFERENCES BARS.DPT_TRUSTEE (KF, ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_AGREEMENTS.sql =========*** E
PROMPT ===================================================================================== 
