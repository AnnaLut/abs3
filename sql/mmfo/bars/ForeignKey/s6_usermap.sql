

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/S6_USERMAP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_S6_USERMAP_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_USERMAP ADD CONSTRAINT FK_S6_USERMAP_BANKS FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/S6_USERMAP.sql =========*** End *
PROMPT ===================================================================================== 
