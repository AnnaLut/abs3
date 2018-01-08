

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACCOUNTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCOUNTS_TOBO ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_TOBO FOREIGN KEY (TOBO)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_ACCOUNTS2 FOREIGN KEY (KF, ACCC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_BANKS FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_NOTIFIERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_NOTIFIERS FOREIGN KEY (NOTIFIER_REF)
	  REFERENCES BARS.NOTIFIERS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_PAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_PAP FOREIGN KEY (PAP)
	  REFERENCES BARS.PAP (PAP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_POS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_POS FOREIGN KEY (POS)
	  REFERENCES BARS.POS (POS) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_RANG ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_RANG FOREIGN KEY (BLKD)
	  REFERENCES BARS.RANG (RANG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_RANG2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_RANG2 FOREIGN KEY (BLKK)
	  REFERENCES BARS.RANG (RANG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_STAFF FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_TIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_VIDS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_VIDS FOREIGN KEY (VID)
	  REFERENCES BARS.VIDS (VID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_ACCOUNT_ACCOUNT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT R_ACCOUNT_ACCOUNT FOREIGN KEY (ACCC)
	  REFERENCES BARS.ACCOUNTS (ACC) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACCOUNTS.sql =========*** End ***
PROMPT ===================================================================================== 
