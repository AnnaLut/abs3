

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUST_REQ_ACCESS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTREQACCESS_CONTRACT_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQ_ACCESS ADD CONSTRAINT FK_CUSTREQACCESS_CONTRACT_ID FOREIGN KEY (CONTRACT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (DEPOSIT_ID) ON DELETE CASCADE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTREQACCESS_REQID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQ_ACCESS ADD CONSTRAINT FK_CUSTREQACCESS_REQID FOREIGN KEY (REQ_ID)
	  REFERENCES BARS.CUST_REQUESTS (REQ_ID) ON DELETE CASCADE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUST_REQ_ACCESS.sql =========*** 
PROMPT ===================================================================================== 
