

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CIN_CUST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CINCUST_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_CUST ADD CONSTRAINT FK_CINCUST_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CIN_CUST.sql =========*** End ***
PROMPT ===================================================================================== 
