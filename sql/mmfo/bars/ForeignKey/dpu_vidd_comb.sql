

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPU_VIDD_COMB.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPUVIDDCOMB_DPUVIDD_MAIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_COMB ADD CONSTRAINT FK_DPUVIDDCOMB_DPUVIDD_MAIN FOREIGN KEY (MAIN_VIDD)
	  REFERENCES BARS.DPU_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDDCOMB_DPUVIDD_DMND ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_COMB ADD CONSTRAINT FK_DPUVIDDCOMB_DPUVIDD_DMND FOREIGN KEY (DMND_VIDD)
	  REFERENCES BARS.DPU_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPU_VIDD_COMB.sql =========*** En
PROMPT ===================================================================================== 
