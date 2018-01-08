

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BIC_ACC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BICACC_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIC_ACC ADD CONSTRAINT FK_BICACC_ACCOUNTS FOREIGN KEY (KF, TRANSIT)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_SWBANKS_BICACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIC_ACC ADD CONSTRAINT R_SWBANKS_BICACC FOREIGN KEY (BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ON DELETE CASCADE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BICACC_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIC_ACC ADD CONSTRAINT FK_BICACC_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BICACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIC_ACC ADD CONSTRAINT FK_BICACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BIC_ACC.sql =========*** End *** 
PROMPT ===================================================================================== 
