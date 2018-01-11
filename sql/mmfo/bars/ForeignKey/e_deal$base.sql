

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/E_DEAL$BASE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_EDEAL_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE ADD CONSTRAINT FK_EDEAL_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_EDEAL_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE ADD CONSTRAINT FK_EDEAL_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_EDEAL_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE ADD CONSTRAINT FK_EDEAL_ACCOUNTS FOREIGN KEY (KF, ACC26)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK2_EDEAL_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE ADD CONSTRAINT FK2_EDEAL_ACCOUNTS FOREIGN KEY (KF, ACC36)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK3_EDEAL_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE ADD CONSTRAINT FK3_EDEAL_ACCOUNTS FOREIGN KEY (KF, ACCD)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FKP_EDEAL_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE ADD CONSTRAINT FKP_EDEAL_ACCOUNTS FOREIGN KEY (KF, ACCP)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_EDEAL_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE ADD CONSTRAINT FK_EDEAL_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/E_DEAL$BASE.sql =========*** End 
PROMPT ===================================================================================== 
