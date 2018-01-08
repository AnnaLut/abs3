

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OTC_C5_PROC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OTCC5PROC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_C5_PROC ADD CONSTRAINT FK_OTCC5PROC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OTC_C5_PROC.sql =========*** End 
PROMPT ===================================================================================== 
