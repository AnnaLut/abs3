

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/EAD_SYNC_QUEUE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_EADSYNCQUEUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_QUEUE ADD CONSTRAINT FK_EADSYNCQUEUE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/EAD_SYNC_QUEUE.sql =========*** E
PROMPT ===================================================================================== 
