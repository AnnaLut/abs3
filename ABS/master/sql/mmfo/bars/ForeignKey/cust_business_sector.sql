

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUST_BUSINESS_SECTOR.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTBIZSECTOR_CUSTBIZLINE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_BUSINESS_SECTOR ADD CONSTRAINT FK_CUSTBIZSECTOR_CUSTBIZLINE FOREIGN KEY (LINE_ID)
	  REFERENCES BARS.CUST_BUSINESS_LINE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUST_BUSINESS_SECTOR.sql ========
PROMPT ===================================================================================== 
