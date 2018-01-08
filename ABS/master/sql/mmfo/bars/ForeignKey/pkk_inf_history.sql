

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PKK_INF_HISTORY.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PKKINFHISTORY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_INF_HISTORY ADD CONSTRAINT FK_PKKINFHISTORY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PKK_INF_HISTORY.sql =========*** 
PROMPT ===================================================================================== 
