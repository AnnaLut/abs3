

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_VOLAP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWVOLAP_SWCHRSETS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_VOLAP ADD CONSTRAINT FK_SWVOLAP_SWCHRSETS FOREIGN KEY (CHRSET)
	  REFERENCES BARS.SW_CHRSETS (SETID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_VOLAP.sql =========*** End ***
PROMPT ===================================================================================== 
