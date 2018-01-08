

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/MC_COUNT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_MC_MFO_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.MC_COUNT ADD CONSTRAINT R_MC_MFO_BANKS FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/MC_COUNT.sql =========*** End ***
PROMPT ===================================================================================== 
