

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SALDOB_OLD.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SALDOB_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOB_OLD ADD CONSTRAINT FK_SALDOB_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SALDOB_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOB_OLD ADD CONSTRAINT FK_SALDOB_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SALDOB_OLD.sql =========*** End *
PROMPT ===================================================================================== 
