

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CONTRACT_P.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CONTRACTP_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACT_P ADD CONSTRAINT FK_CONTRACTP_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CONTRACTP_CONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACT_P ADD CONSTRAINT FK_CONTRACTP_CONTRACTS FOREIGN KEY (ID)
	  REFERENCES BARS.CONTRACTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CONTRACTP_TOPCONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACT_P ADD CONSTRAINT FK_CONTRACTP_TOPCONTRACTS FOREIGN KEY (PID)
	  REFERENCES BARS.TOP_CONTRACTS (PID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CONTRACT_P.sql =========*** End *
PROMPT ===================================================================================== 
