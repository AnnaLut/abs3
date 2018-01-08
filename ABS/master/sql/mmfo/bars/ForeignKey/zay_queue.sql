

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ZAY_QUEUE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ZAYQUEUE_ZAYAVKA ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_QUEUE ADD CONSTRAINT FK_ZAYQUEUE_ZAYAVKA FOREIGN KEY (ID)
	  REFERENCES BARS.ZAYAVKA (ID) ON DELETE CASCADE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYQUEUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_QUEUE ADD CONSTRAINT FK_ZAYQUEUE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ZAY_QUEUE.sql =========*** End **
PROMPT ===================================================================================== 
