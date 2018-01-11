

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBU_CONTR.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NBUCONTR_TOPCONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU_CONTR ADD CONSTRAINT FK_NBUCONTR_TOPCONTRACTS FOREIGN KEY (PID)
	  REFERENCES BARS.TOP_CONTRACTS (PID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBUCONTR_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU_CONTR ADD CONSTRAINT FK_NBUCONTR_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBU_CONTR.sql =========*** End **
PROMPT ===================================================================================== 
