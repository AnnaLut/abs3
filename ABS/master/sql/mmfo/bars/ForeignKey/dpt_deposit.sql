

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_DEPOSIT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPT_DEPOSIT_DPT_D ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPT_DEPOSIT_DPT_D FOREIGN KEY (DPT_D)
	  REFERENCES BARS.DPT_DEPOSIT (DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_ACCOUNTS3 FOREIGN KEY (KF, ACC_D)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_DPTDEPOSIT2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_DPTDEPOSIT2 FOREIGN KEY (KF, DPT_D)
	  REFERENCES BARS.DPT_DEPOSIT (KF, DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_BANKS2 FOREIGN KEY (MFO_D)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_BANKS FOREIGN KEY (MFO_P)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_FREQ FOREIGN KEY (FREQ)
	  REFERENCES BARS.FREQ (FREQ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_DPTSTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_DPTSTOP FOREIGN KEY (STOP_ID)
	  REFERENCES BARS.DPT_STOP (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_DPTDPTALL2 FOREIGN KEY (KF, DEPOSIT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_DEPOSIT.sql =========*** End 
PROMPT ===================================================================================== 
