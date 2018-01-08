

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_PAYMENT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STO_PAYM_REFERENCE_STO_ORDE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT ADD CONSTRAINT FK_STO_PAYM_REFERENCE_STO_ORDE FOREIGN KEY (ORDER_ID)
	  REFERENCES BARS.STO_ORDER (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STOPAYMENT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT ADD CONSTRAINT FK_STOPAYMENT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STOPAYMENT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT ADD CONSTRAINT FK_STOPAYMENT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_PAYMENT.sql =========*** End 
PROMPT ===================================================================================== 
