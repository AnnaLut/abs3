

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_PROCQUE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWPROCQUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_PROCQUE ADD CONSTRAINT FK_SWPROCQUE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWPROCQUE_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_PROCQUE ADD CONSTRAINT FK_SWPROCQUE_SWJOURNAL FOREIGN KEY (KF, SWREF)
	  REFERENCES BARS.SW_JOURNAL (KF, SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_PROCQUE.sql =========*** End *
PROMPT ===================================================================================== 
