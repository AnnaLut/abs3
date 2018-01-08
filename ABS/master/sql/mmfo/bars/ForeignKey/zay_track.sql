

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ZAY_TRACK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ZAYTRACK_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK ADD CONSTRAINT FK_ZAYTRACK_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYTRACK_ZAYAVKA ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK ADD CONSTRAINT FK_ZAYTRACK_ZAYAVKA FOREIGN KEY (ID)
	  REFERENCES BARS.ZAYAVKA (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ZAY_TRACK.sql =========*** End **
PROMPT ===================================================================================== 
