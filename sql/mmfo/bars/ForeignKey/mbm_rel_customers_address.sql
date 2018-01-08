

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/MBM_REL_CUSTOMERS_ADDRESS.sql ===
PROMPT ===================================================================================== 


PROMPT *** Create  constraint SYS_C00111430 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_REL_CUSTOMERS_ADDRESS ADD FOREIGN KEY (REL_CUST_ID)
	  REFERENCES BARS.MBM_REL_CUSTOMERS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/MBM_REL_CUSTOMERS_ADDRESS.sql ===
PROMPT ===================================================================================== 
