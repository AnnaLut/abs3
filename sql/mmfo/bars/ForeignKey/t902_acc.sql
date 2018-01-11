

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/T902_ACC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_T902ACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.T902_ACC ADD CONSTRAINT FK_T902ACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/T902_ACC.sql =========*** End ***
PROMPT ===================================================================================== 
