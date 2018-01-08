

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OTCN_HISTORY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OTCN_HISTORY_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_HISTORY ADD CONSTRAINT FK_OTCN_HISTORY_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OTCNHISTORY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_HISTORY ADD CONSTRAINT FK_OTCNHISTORY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OTCN_HISTORY.sql =========*** End
PROMPT ===================================================================================== 
