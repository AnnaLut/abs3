

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/VIDD_TIP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_VIDDTIP_TIP_TIPS_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIDD_TIP ADD CONSTRAINT FK_VIDDTIP_TIP_TIPS_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VIDDTIP_VIDD_CCVIDD_VIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIDD_TIP ADD CONSTRAINT FK_VIDDTIP_VIDD_CCVIDD_VIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.CC_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/VIDD_TIP.sql =========*** End ***
PROMPT ===================================================================================== 
