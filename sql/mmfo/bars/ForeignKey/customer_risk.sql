

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_RISK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTOMERRISK_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_RISK ADD CONSTRAINT FK_CUSTOMERRISK_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERRISK_FMRISKCRITERIA ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_RISK ADD CONSTRAINT FK_CUSTOMERRISK_FMRISKCRITERIA FOREIGN KEY (RISK_ID)
	  REFERENCES BARS.FM_RISK_CRITERIA (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERRISK_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_RISK ADD CONSTRAINT FK_CUSTOMERRISK_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_RISK.sql =========*** En
PROMPT ===================================================================================== 
