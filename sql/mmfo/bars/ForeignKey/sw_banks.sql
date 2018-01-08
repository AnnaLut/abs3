

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_BANKS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWBANKS_SWCHRSETS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_BANKS ADD CONSTRAINT FK_SWBANKS_SWCHRSETS FOREIGN KEY (CHRSET)
	  REFERENCES BARS.SW_CHRSETS (SETID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_BANKS.sql =========*** End ***
PROMPT ===================================================================================== 
