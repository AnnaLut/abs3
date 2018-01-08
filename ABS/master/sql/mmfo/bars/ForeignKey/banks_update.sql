

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BANKS_UPDATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BANKSUPD_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS_UPDATE ADD CONSTRAINT FK_BANKSUPD_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKSUPD_BANKSUPDHDR2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS_UPDATE ADD CONSTRAINT FK_BANKSUPD_BANKSUPDHDR2 FOREIGN KEY (KF, HEADER)
	  REFERENCES BARS.BANKS_UPDATE_HDR (KF, ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_BNKUPDHD_BNKUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS_UPDATE ADD CONSTRAINT R_BNKUPDHD_BNKUPD FOREIGN KEY (HEADER)
	  REFERENCES BARS.BANKS_UPDATE_HDR (ID) ON DELETE CASCADE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BANKS_UPDATE.sql =========*** End
PROMPT ===================================================================================== 
