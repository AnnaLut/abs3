

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_IFC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_SWBANKS_CUSTOMER_IFC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_IFC ADD CONSTRAINT R_SWBANKS_CUSTOMER_IFC FOREIGN KEY (NOSTRO_BANK)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_INTERBANK_CUSTOMERIFC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_IFC ADD CONSTRAINT R_INTERBANK_CUSTOMERIFC FOREIGN KEY (FLI)
	  REFERENCES BARS.INTERBANK (FLI) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_IFC.sql =========*** End
PROMPT ===================================================================================== 
