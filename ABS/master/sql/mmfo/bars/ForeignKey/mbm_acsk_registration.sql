

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/MBM_ACSK_REGISTRATION.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint SYS_C00111432 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_ACSK_REGISTRATION ADD FOREIGN KEY (REL_CUST_ID)
	  REFERENCES BARS.MBM_REL_CUSTOMERS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/MBM_ACSK_REGISTRATION.sql =======
PROMPT ===================================================================================== 
