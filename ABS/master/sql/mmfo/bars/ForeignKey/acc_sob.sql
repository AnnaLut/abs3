

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACC_SOB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCSOB_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_SOB ADD CONSTRAINT FK_ACCSOB_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCSOB_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_SOB ADD CONSTRAINT FK_ACCSOB_STAFF FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCSOB_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_SOB ADD CONSTRAINT FK_ACCSOB_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACC_SOB.sql =========*** End *** 
PROMPT ===================================================================================== 
