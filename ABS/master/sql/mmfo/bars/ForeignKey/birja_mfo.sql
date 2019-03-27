

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BIRJA_MFO.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BIRJA_MFO_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIRJA_MFO ADD CONSTRAINT FK_BIRJA_MFO_BANKS FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BIRJA_MFO.sql =========*** End **
PROMPT ===================================================================================== 