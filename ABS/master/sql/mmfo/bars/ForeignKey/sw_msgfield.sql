

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_MSGFIELD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWMSGFIELD_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGFIELD ADD CONSTRAINT FK_SWMSGFIELD_SWJOURNAL FOREIGN KEY (SWREF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWMSGFIELD_SWMSGTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGFIELD ADD CONSTRAINT FK_SWMSGFIELD_SWMSGTAG FOREIGN KEY (MSGBLK, MSGTAG)
	  REFERENCES BARS.SW_MSGTAG (MSGBLK, MSGTAG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWMSGFIELD_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGFIELD ADD CONSTRAINT FK_SWMSGFIELD_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWMSGFIELD_SWJOURNAL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGFIELD ADD CONSTRAINT FK_SWMSGFIELD_SWJOURNAL2 FOREIGN KEY (KF, SWREF)
	  REFERENCES BARS.SW_JOURNAL (KF, SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_MSGFIELD.sql =========*** End 
PROMPT ===================================================================================== 
