

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NAEK_HEADERS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NAEKHEADERS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_HEADERS ADD CONSTRAINT FK_NAEKHEADERS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NAEK_HEADERS.sql =========*** End
PROMPT ===================================================================================== 
