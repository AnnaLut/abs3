

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BANK_ACC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BANKACC_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_ACC ADD CONSTRAINT FK_BANKACC_BANKS FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKACC_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_ACC ADD CONSTRAINT FK_BANKACC_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKACC_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_ACC ADD CONSTRAINT FK_BANKACC_BANKS2 FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BANK_ACC.sql =========*** End ***
PROMPT ===================================================================================== 
