

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CONTRACTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CONTRACTS_TOPCONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACTS ADD CONSTRAINT FK_CONTRACTS_TOPCONTRACTS FOREIGN KEY (PID)
	  REFERENCES BARS.TOP_CONTRACTS (PID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CONTRACTS.sql =========*** End **
PROMPT ===================================================================================== 
