

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_OPER.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWOPER_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPER ADD CONSTRAINT FK_SWOPER_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWOPER_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPER ADD CONSTRAINT FK_SWOPER_SWJOURNAL FOREIGN KEY (SWREF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_OPER.sql =========*** End *** 
PROMPT ===================================================================================== 
