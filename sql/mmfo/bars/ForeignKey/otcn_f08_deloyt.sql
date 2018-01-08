

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OTCN_F08_DELOYT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OTCNF08DELOYT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F08_DELOYT ADD CONSTRAINT FK_OTCNF08DELOYT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OTCN_F08_DELOYT.sql =========*** 
PROMPT ===================================================================================== 
