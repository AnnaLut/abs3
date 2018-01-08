

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_EXTCONSENT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTEXTCONSENT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTCONSENT ADD CONSTRAINT FK_DPTEXTCONSENT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_EXTCONSENT.sql =========*** E
PROMPT ===================================================================================== 
