

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPU_VIDD_RATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPUVIDDRATE_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT FK_DPUVIDDRATE_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDDRATE_DPUTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT FK_DPUVIDDRATE_DPUTYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.DPU_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDDRATE_DPUVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT FK_DPUVIDDRATE_DPUVIDD FOREIGN KEY (VIDD, TYPE_ID)
	  REFERENCES BARS.DPU_VIDD (VIDD, TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPU_VIDD_RATE.sql =========*** En
PROMPT ===================================================================================== 
