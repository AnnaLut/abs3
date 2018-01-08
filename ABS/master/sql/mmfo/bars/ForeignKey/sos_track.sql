

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SOS_TRACK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SOSTRACK_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS_TRACK ADD CONSTRAINT FK_SOSTRACK_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOSTRACK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS_TRACK ADD CONSTRAINT FK_SOSTRACK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SOS_TRACK.sql =========*** End **
PROMPT ===================================================================================== 
