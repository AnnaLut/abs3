

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_TECHACCOUNTS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPT_TECHACC_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS ADD CONSTRAINT FK_DPT_TECHACC_ACCOUNTS2 FOREIGN KEY (KF, DPT_ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPT_TECHACC_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS ADD CONSTRAINT FK_DPT_TECHACC_ACCOUNTS3 FOREIGN KEY (KF, TECH_ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPT_TECHACC_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS ADD CONSTRAINT FK_DPT_TECHACC_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTTECHACC_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS ADD CONSTRAINT FK_DPTTECHACC_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPT_TECHACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS ADD CONSTRAINT FK_DPT_TECHACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPT_TECHACC_DPTDEPOSITCLOS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS ADD CONSTRAINT FK_DPT_TECHACC_DPTDEPOSITCLOS2 FOREIGN KEY (KF, DPT_IDUPD)
	  REFERENCES BARS.DPT_DEPOSIT_CLOS (KF, IDUPD) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPT_TECHACC_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS ADD CONSTRAINT FK_DPT_TECHACC_DPTDPTALL2 FOREIGN KEY (KF, DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_TECHACCOUNTS.sql =========***
PROMPT ===================================================================================== 
