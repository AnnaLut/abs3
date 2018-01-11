

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_DEPOSIT_CLOS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_ACCOUNTS4 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_ACCOUNTS4 FOREIGN KEY (KF, ACC_D)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_DPTDPTALL3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_DPTDPTALL3 FOREIGN KEY (KF, DEPOSIT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_BANKS2 FOREIGN KEY (MFO_D)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_FREQ FOREIGN KEY (FREQ)
	  REFERENCES BARS.FREQ (FREQ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_BANKS FOREIGN KEY (MFO_P)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_STAFF FOREIGN KEY (ACTIION_AUTHOR)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_DPTSTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_DPTSTOP FOREIGN KEY (STOP_ID)
	  REFERENCES BARS.DPT_STOP (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_DPTDPTALL4 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_DPTDPTALL4 FOREIGN KEY (KF, DPT_D)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_ACCOUNTS3 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_STAFF2 FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITCLOS_DPTDEPACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT FK_DPTDEPOSITCLOS_DPTDEPACTION FOREIGN KEY (ACTION_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ACTION (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_DEPOSIT_CLOS.sql =========***
PROMPT ===================================================================================== 
