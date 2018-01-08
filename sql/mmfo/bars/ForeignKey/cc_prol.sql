

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_PROL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CCPROL_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PROL ADD CONSTRAINT FK_CCPROL_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCPROL_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PROL ADD CONSTRAINT FK_CCPROL_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_PROL.sql =========*** End *** 
PROMPT ===================================================================================== 
