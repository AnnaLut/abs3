

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUST_NAL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTNAL_TOPCONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_NAL ADD CONSTRAINT FK_CUSTNAL_TOPCONTRACTS FOREIGN KEY (PID)
	  REFERENCES BARS.TOP_CONTRACTS (PID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUST_NAL_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_NAL ADD CONSTRAINT FK_CUST_NAL_KV FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUST_NAL_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_NAL ADD CONSTRAINT FK_CUST_NAL_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUST_NAL.sql =========*** End ***
PROMPT ===================================================================================== 
