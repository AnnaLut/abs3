

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OTCN_LOG.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OTCNLOG_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_LOG ADD CONSTRAINT FK_OTCNLOG_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OTCNLOG_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_LOG ADD CONSTRAINT FK_OTCNLOG_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OTCN_LOG.sql =========*** End ***
PROMPT ===================================================================================== 
