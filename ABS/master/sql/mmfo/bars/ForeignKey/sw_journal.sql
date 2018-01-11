

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_JOURNAL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWJOURNAL_SWMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT FK_SWJOURNAL_SWMT FOREIGN KEY (MT)
	  REFERENCES BARS.SW_MT (MT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWJOURNAL_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT FK_SWJOURNAL_TABVAL FOREIGN KEY (CURRENCY)
	  REFERENCES BARS.TABVAL$GLOBAL (LCV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWJOURNAL_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT FK_SWJOURNAL_STAFF2 FOREIGN KEY (LAU_UID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWJOURNAL_SWBANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT FK_SWJOURNAL_SWBANKS FOREIGN KEY (SENDER)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWJOURNAL_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT FK_SWJOURNAL_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWJOURNAL_SWBANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT FK_SWJOURNAL_SWBANKS2 FOREIGN KEY (RECEIVER)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWJOURNAL_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT FK_SWJOURNAL_ACCOUNTS3 FOREIGN KEY (KF, ACCK)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWJOURNAL_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT FK_SWJOURNAL_ACCOUNTS2 FOREIGN KEY (KF, ACCD)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_JOURNAL.sql =========*** End *
PROMPT ===================================================================================== 
