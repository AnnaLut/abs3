

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_RATE_RISE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTRATERISE_INTIDN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_RATE_RISE ADD CONSTRAINT FK_DPTRATERISE_INTIDN FOREIGN KEY (ID)
	  REFERENCES BARS.INT_IDN (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTRATERISE_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_RATE_RISE ADD CONSTRAINT FK_DPTRATERISE_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTRATERISE_INTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_RATE_RISE ADD CONSTRAINT FK_DPTRATERISE_INTOP FOREIGN KEY (OP)
	  REFERENCES BARS.INT_OP (OP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_RATE_RISE.sql =========*** En
PROMPT ===================================================================================== 
