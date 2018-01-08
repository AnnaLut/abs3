

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CIG_CUST_COMPANY.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CIGCUSTCOMP_CIGCUSTOMERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_COMPANY ADD CONSTRAINT FK_CIGCUSTCOMP_CIGCUSTOMERS FOREIGN KEY (CUST_ID, BRANCH)
	  REFERENCES BARS.CIG_CUSTOMERS (CUST_ID, BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CIG_CUST_COMPANY.sql =========***
PROMPT ===================================================================================== 
