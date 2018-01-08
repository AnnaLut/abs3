

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SOS0QUE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SOS0QUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS0QUE ADD CONSTRAINT FK_SOS0QUE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SOS0QUE.sql =========*** End *** 
PROMPT ===================================================================================== 
