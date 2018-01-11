

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_LIM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CCLIM_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM ADD CONSTRAINT FK_CCLIM_ACCOUNTS FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_LIM ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM ADD CONSTRAINT FK_CC_LIM FOREIGN KEY (ND)
	  REFERENCES BARS.CC_DEAL (ND) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCLIM_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM ADD CONSTRAINT FK_CCLIM_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_LIM.sql =========*** End *** =
PROMPT ===================================================================================== 
