

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTBANK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_SWBANKS_CUSTBANK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTBANK ADD CONSTRAINT R_SWBANKS_CUSTBANK FOREIGN KEY (BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTBANK_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTBANK ADD CONSTRAINT FK_CUSTBANK_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTBANK_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTBANK ADD CONSTRAINT FK_CUSTBANK_BANKS FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTBANK.sql =========*** End ***
PROMPT ===================================================================================== 
