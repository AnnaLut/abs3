

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACCOUNTSW.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCOUNTSW_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW ADD CONSTRAINT FK_ACCOUNTSW_ACC FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSW_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW ADD CONSTRAINT FK_ACCOUNTSW_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSW_ACCOUNTSFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW ADD CONSTRAINT FK_ACCOUNTSW_ACCOUNTSFIELD FOREIGN KEY (TAG)
	  REFERENCES BARS.ACCOUNTS_FIELD (TAG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSW_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW ADD CONSTRAINT FK_ACCOUNTSW_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACCOUNTSW.sql =========*** End **
PROMPT ===================================================================================== 
