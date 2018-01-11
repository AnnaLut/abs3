

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PEREKR_G.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PEREKRG_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_G ADD CONSTRAINT FK_PEREKRG_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PEREKR_G.sql =========*** End ***
PROMPT ===================================================================================== 
