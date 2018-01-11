

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACCOUNTS_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCOUNTSUPD_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_ACCOUNTS3 FOREIGN KEY (KF, ACCC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACCOUNTS_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
