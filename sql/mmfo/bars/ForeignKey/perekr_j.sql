

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PEREKR_J.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PEREKRJ_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_J ADD CONSTRAINT FK_PEREKRJ_ACCOUNTS FOREIGN KEY (ACCS)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRJ_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_J ADD CONSTRAINT FK_PEREKRJ_ACCOUNTS3 FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRJ_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_J ADD CONSTRAINT FK_PEREKRJ_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PEREKR_J.sql =========*** End ***
PROMPT ===================================================================================== 
