

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_VIDD_BONUSES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTVIDDBONUS_DPTBONUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BONUSES ADD CONSTRAINT FK_DPTVIDDBONUS_DPTBONUS FOREIGN KEY (BONUS_ID)
	  REFERENCES BARS.DPT_BONUSES (BONUS_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDDBONUS_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BONUSES ADD CONSTRAINT FK_DPTVIDDBONUS_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_VIDD_BONUSES.sql =========***
PROMPT ===================================================================================== 
