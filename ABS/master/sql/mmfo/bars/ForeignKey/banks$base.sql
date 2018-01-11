

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BANKS$BASE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BANKS_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$BASE ADD CONSTRAINT FK_BANKS_BANKS2 FOREIGN KEY (MFOU)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BANKS$BASE.sql =========*** End *
PROMPT ===================================================================================== 
